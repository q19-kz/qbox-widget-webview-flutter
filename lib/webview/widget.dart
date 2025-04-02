import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qbox_widget_webview/models/callbacks.dart';
import 'package:qbox_widget_webview/models/settings.dart';
import 'package:qbox_widget_webview/webview/debug.dart';
import 'package:qbox_widget_webview/webview/download.dart';
import 'package:qbox_widget_webview/webview/permission.dart';
import 'package:simple_pip_mode/simple_pip.dart';

class WebWidget extends StatefulWidget {
  final Settings settings;
  final Callbacks? callbacks;

  const WebWidget(this.settings, [this.callbacks, Key? key]) : super(key: key);

  @override
  State<WebWidget> createState() => _WebWidgetState();
}

class _WebWidgetState extends State<WebWidget>
    with WidgetsBindingObserver, DownloadMixin, DebugMixin {
  InAppWebViewController? controller;
  SimplePip? pip;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    PlatformInAppWebViewController.debugLoggingSettings.enabled = false;

    _enableAutoPiP();
  }

  Future<void> _enableAutoPiP() async {
    pip ??= SimplePip(
      onPipEntered: () async {
        widget.callbacks?.onPiPState?.call('entered');
      },
      onPipExited: () async {
        widget.callbacks?.onPiPState?.call('exited');
      },
    );

    final isAvailable = await SimplePip.isAutoPipAvailable;
    if (isAvailable) {
      await pip?.setAutoPipMode(
        autoEnter: true,
        seamlessResize: true,
        aspectRatio: (9, 16),
      );
    }
  }

  bool log(String? message) {
    if (!widget.settings.loggingEnabled || message == null || message.isEmpty) {
      return false;
    }
    debugPrint('[QBox] $message');
    return true;
  }

  URLRequest getURL() {
    WebUri uri = WebUri(widget.settings.getUri().toString());
    return URLRequest(url: uri);
  }

  void onWebViewCreated(InAppWebViewController controller) {
    this.controller = controller;

    if (widget.callbacks != null) {
      controller.addJavaScriptHandler(
        handlerName: 'CallState',
        callback: (args) {
          if (args.isNotEmpty) {
            widget.callbacks?.onCallState?.call(args[0]);
          }
        },
      );
    }
  }

  InAppWebViewSettings getWebViewSettings() {
    return InAppWebViewSettings(
      allowsInlineMediaPlayback: true,
      allowsAirPlayForMediaPlayback: true,
      allowsPictureInPictureMediaPlayback: true,
      cacheEnabled: false,
      javaScriptEnabled: true,
      javaScriptCanOpenWindowsAutomatically: true,
      ignoresViewportScaleLimits: true,
      mediaPlaybackRequiresUserGesture: false,
    );
  }

  void onPageLoadProgress(InAppWebViewController controller, int progress) {
    widget.callbacks?.onPageLoadProgress?.call(progress);
  }

  void onPageLoadFinished(InAppWebViewController controller, WebUri? url) {
    final json = jsonEncode(widget.settings);
    controller.evaluateJavascript(source: 'iosData=$json;');

    widget.callbacks?.onPageLoadFinished?.call(url?.uriValue);
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: getURL(),
      initialSettings: getWebViewSettings(),
      onWebViewCreated: onWebViewCreated,
      onPermissionRequest: onPermissionRequest,
      onProgressChanged: onPageLoadProgress,
      onLoadStop: onPageLoadFinished,
      onDownloadStartRequest: (controller, downloadStart) =>
          onDownloadStart(controller, downloadStart, widget.callbacks),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
