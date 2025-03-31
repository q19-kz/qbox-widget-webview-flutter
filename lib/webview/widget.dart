import 'dart:convert';
import 'dart:io';
import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'base.dart';
import 'debug.dart';
import 'download.dart';
import 'permission.dart';

class WebWidget extends BaseController
    with WidgetsBindingObserver, DebugMixin, DownloadMixin {
  final Floating floating = Floating();
  bool _pipClosedManually = false;

  WebWidget(super.settings, [super.callbacks]) {
    WidgetsBinding.instance.addObserver(this);
    floating.pipStatusStream.listen((status) {
      if (status == PiPStatus.disabled) {
        debugPrint("PiP closed by user. Bringing app to foreground...");
        _bringAppToFront();
      }
    });
  }

  Widget build() {
    PlatformInAppWebViewController.debugLoggingSettings.enabled = false;

    return InAppWebView(
      initialUrlRequest: assembleRequest(),
      initialSettings: getWebViewSettings(),
      onWebViewCreated: setupController,
      onPermissionRequest: handlePermission,
      onLoadStop: onPageFinished,
      onProgressChanged: (controller, progress) {
        callbacks?.onPageLoadProgress?.call(progress);
      },
      onDownloadStartRequest: onDownloadStart,
    );
  }

  void onPageFinished(InAppWebViewController webViewController, WebUri? url) {
    callbacks?.onPageLoadFinished?.call(url?.uriValue);

    final json = jsonEncode(settings);
    controller?.evaluateJavascript(source: 'flutterData=$json;');
  }

  void updateSettings(settings) {
    this.settings = settings;
    controller?.loadUrl(urlRequest: assembleRequest());
  }

  Future<void> startPiPMode() async {
    if (_pipClosedManually) {
      debugPrint("PiP was closed manually. Skipping auto PiP.");
      return;
    }

    final canUsePiP = await floating.isPipAvailable;
    final currentStatus = await floating.pipStatus;

    if (canUsePiP && currentStatus != PiPStatus.enabled) {
      debugPrint("Attempting to start PiP Mode...");
      await floating.enable(const ImmediatePiP(
        aspectRatio: Rational(300, 600),
      ));
      debugPrint("PiP Mode Started Successfully.");
    }
  }

  Future<void> stopPiPMode() async {
    final currentStatus = await floating.pipStatus;
    if (currentStatus == PiPStatus.enabled) {
      debugPrint("Disabling PiP Mode...");
      await floating.cancelOnLeavePiP();
      _pipClosedManually = true;
      debugPrint("PiP Mode Disabled Completely.");
    }
  }

  void _bringAppToFront() {
    if (Platform.isAndroid) {
      const platform = MethodChannel("com.pip.app/channel");
      platform.invokeMethod("moveTaskToFront");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      debugPrint("App is going to background, enabling PiP...");
      await startPiPMode();
    } else if (state == AppLifecycleState.resumed) {
      debugPrint("App is Resumed, disabling PiP...");
      await stopPiPMode();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    stopPiPMode();
  }
}
