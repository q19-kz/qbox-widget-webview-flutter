import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qbox_widget_webview/models/callbacks.dart';
import 'package:qbox_widget_webview/models/settings.dart';

class BaseController {
  Settings settings;
  final Callbacks? callbacks;
  InAppWebViewController? controller;

  BaseController(this.settings, [this.callbacks]);

  void log(String? message) {
    if (settings.loggingEnabled) {
      debugPrint(message);
    }
  }

  void setupController(webViewController) {
    controller = webViewController;

    controller?.addJavaScriptHandler(
        handlerName: 'CallState',
        callback: (args) {
          final state = args.isEmpty ? null : args[0];
          (callbacks?.onCallState ?? log).call(state);
        });
  }

  // MARK: Configuration
  URLRequest assembleRequest() {
    return URLRequest(
        url: WebUri(settings.url)
          ..replace(queryParameters: settings.getUriParams()));
  }

  InAppWebViewSettings getWebViewSettings() {
    return InAppWebViewSettings(
      allowsInlineMediaPlayback: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsAirPlayForMediaPlayback: true,
      allowsPictureInPictureMediaPlayback: true,
      javaScriptEnabled: true,
      javaScriptCanOpenWindowsAutomatically: true,
      ignoresViewportScaleLimits: true,
      cacheEnabled: false,
    );
  }
}
