import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qbox_widget_webview/models/callbacks.dart';
import 'package:qbox_widget_webview/models/settings.dart';

class BaseController {
  Settings settings;
  final Callbacks? callbacks;
  InAppWebViewController? controller;

  BaseController(this.settings, [this.callbacks]);

  bool log(String? message) {
    if (!settings.loggingEnabled) {
      return false;
    }
    if (message == null) {
      return false;
    }
    if (message.isEmpty) {
      return false;
    }
    debugPrint('[QBox] $message');
    return true;
  }

  void setupController(webViewController) {
    controller = webViewController;

    if (callbacks != null) {
      controller?.addJavaScriptHandler(
        handlerName: 'CallState',
        callback: (args) {
          if (args.isNotEmpty) {
            callbacks?.onCallState?.call(args[0]);
          }
        },
      );
    }
  }

  // MARK: Configuration
  URLRequest assembleRequest() {
    WebUri uri = WebUri(settings.getUri().toString());
    return URLRequest(url: uri);
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
