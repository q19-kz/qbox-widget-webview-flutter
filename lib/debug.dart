
import 'base.dart';


mixin DebugMixin on BaseWebWidget{

  void testCallState(){
    controller?.evaluateJavascript(source: '''
    var testState = "TEST";
    if (window.flutter_inappwebview) {
      window.flutter_inappwebview.callHandler('CallState', testState);
    };
    ''');
  }
}
