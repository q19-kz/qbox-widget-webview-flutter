import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:simple_pip_mode/simple_pip.dart';

import 'base.dart';
import 'debug.dart';
import 'download.dart';
import 'permission.dart';
import 'package:qbox_widget_webview/models/callbacks.dart';
import 'package:qbox_widget_webview/models/settings.dart';

class WebWidget extends StatefulWidget {
  final Settings settings;
  final Callbacks? callbacks;

  const WebWidget(this.settings, [this.callbacks, Key? key]) : super(key: key);

  @override
  State<WebWidget> createState() => _WebWidgetState();
}

class _WebWidgetState extends State<WebWidget>
    with
        WidgetsBindingObserver,
        DownloadMixin,
        BaseControllerMixin,
        DebugMixin {
  late SimplePip pip;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    settings = widget.settings;
    callbacks = widget.callbacks;

    pip = SimplePip(
      onPipExited: () async {
        debugPrint("\ud83d\udce4 PiP mode exited (X button pressed)");
      },
    );

    _enableAutoPiP();
  }

  Future<void> _enableAutoPiP() async {
    final isAvailable = await SimplePip.isAutoPipAvailable;
    if (isAvailable) {
      await pip.setAutoPipMode(
        autoEnter: true,
        seamlessResize: true,
        aspectRatio: (9, 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      onDownloadStartRequest: (controller, downloadStart) =>
          onDownloadStart(controller, downloadStart, callbacks),
    );
  }

  void onPageFinished(InAppWebViewController webViewController, WebUri? url) {
    callbacks?.onPageLoadFinished?.call(url?.uriValue);
    final json = jsonEncode(settings);
    controller?.evaluateJavascript(source: 'flutterData=$json;');
  }

  void updateSettings(Settings settings) {
    this.settings = settings;
    controller?.loadUrl(urlRequest: assembleRequest());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
