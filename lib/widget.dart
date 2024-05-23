
library qbox_widget_webview;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'models/init.dart';
export 'models/init.dart';


class WebWidget {
  final WebViewController controller;
  final Settings _settings;

  // constructor
  factory WebWidget(Settings settings) =>
      WebWidget._internal(WebViewController(), settings);

  const WebWidget._internal(this.controller, this._settings);

  // configuration
  Uri _generateUrl() {
    var params = <String, String>{
      'lang': _settings.language.value
    };

    if (_settings.call case var call?) {
      params['topic'] = call.topic;
    }
    if (_settings.mobileRequired != null || _settings.url.contains('/widget')) {
      params['is_mobile'] = 'True';
    }

    return
      Uri.parse(_settings.url)
          .replace(queryParameters: params);
  }

  void _configController() {
    controller
      ..loadRequest(_generateUrl())
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  // public methods
  Widget build() {
    _configController();

    return WebViewWidget(
      controller: controller,
    );
  }

}
