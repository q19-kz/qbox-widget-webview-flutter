mixin DebugMixin {
  void testCallState(controller) {
    controller?.evaluateJavascript(source: '''
    var testState = "TEST";
    if (window.flutter_inappwebview) {
      window.flutter_inappwebview.callHandler('CallState', testState);
    };
    ''');
  }
}
