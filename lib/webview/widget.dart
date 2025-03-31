import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'base.dart';
import 'debug.dart';
import 'download.dart';
import 'permission.dart';

class WebWidget extends BaseController
    with WidgetsBindingObserver, DebugMixin, DownloadMixin {
  WebWidget(super.settings, [super.callbacks]) {
    WidgetsBinding.instance.addObserver(this);
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      debugPrint('App is in background');
      _onAppWentToBackground();
    } else if (state == AppLifecycleState.resumed) {
      debugPrint('App is back in foreground');
      _onAppResumed();
    }
  }

  void _onAppWentToBackground() {
    debugPrint("App paused — video call may be interrupted.");
  }

  void _onAppResumed() {
    debugPrint("App resumed — rechecking video state.");
  }

  void dispose() => WidgetsBinding.instance.removeObserver(this);
}
