import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'base.dart';
import 'debug.dart';
import 'download.dart';
import 'permission.dart';

class WebWidget extends BaseController with DebugMixin, DownloadMixin {
  WebWidget(super.settings, [super.callbacks]);

  // MARK: Widget
  Widget build() {
    PlatformInAppWebViewController.debugLoggingSettings.enabled = false;

    return InAppWebView(
      initialUrlRequest: assembleRequest(),
      initialSettings: getWebViewSettings(),
      onWebViewCreated: setupController,
      onPermissionRequest: handlePermission,
      onLoadStop: onPageFinished,
      onProgressChanged: (controller, progress) {
        callbacks?.onProgressChanged?.call(progress);
      },
      // shouldOverrideUrlLoading: onUrlOverride,
      onDownloadStartRequest: onDownloadStart,
    );
  }

  void onPageFinished(webViewController, url) {
    callbacks?.onPageFinished?.call(url.toString());

    final json = jsonEncode(settings);
    controller?.evaluateJavascript(source: 'iosData=$json;');
  }

  void reloadPage() {
    controller?.reload();
  }

  void updateSettings(settings) {
    this.settings = settings;
    controller?.loadUrl(urlRequest: assembleRequest());
  }
}
