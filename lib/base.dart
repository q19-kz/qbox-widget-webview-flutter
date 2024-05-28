
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'models/init.dart';
import 'permission.dart';


class BaseWebWidget {
  final Settings settings;
  final Callbacks? callbacks;
  InAppWebViewController? controller;

  BaseWebWidget(this.settings, [this.callbacks]);

  void log(String? message) {
    if (settings.loggingEnabled) {
      debugPrint(message);
    }
  }

  // MARK: Widget
  Widget build() {
    PlatformInAppWebViewController.debugLoggingSettings.enabled = false;

    return InAppWebView(
      initialUrlRequest: URLRequest(
          url: WebUri(settings.url)
            ..replace(queryParameters: settings.getUriParams())
      ),
      initialSettings: getWebViewSettings(),
      onWebViewCreated: setupController,
      onPermissionRequest: handlePermission,
      onLoadStop: onPageFinished,
      onDownloadStartRequest: (controller, downloadStart) async {
        final browser = ChromeSafariBrowser();
        await browser.open(
          url: downloadStart.url,
          settings: ChromeSafariBrowserSettings(
            shareState: CustomTabsShareState.SHARE_STATE_OFF,
            barCollapsingEnabled: true,
          )
        );
      },
    );
  }

  // MARK: Configuration
  InAppWebViewSettings getWebViewSettings() {
    return InAppWebViewSettings(
      allowsInlineMediaPlayback: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsAirPlayForMediaPlayback: true,
      allowsPictureInPictureMediaPlayback: true,
      javaScriptEnabled: true,
      javaScriptCanOpenWindowsAutomatically: true,
      ignoresViewportScaleLimits: true
    );
  }

  void setupController(webViewController) {
    controller = webViewController;
    callbacks?.addJavascriptHandlers(controller);
  }

  void onPageFinished(webViewController, url) {
    callbacks?.onPageFinished?.call(url);

    final json = jsonEncode(settings);
    controller?.evaluateJavascript(source: 'iosData=$json;');
  }
}
