
class Callbacks {
  final void Function(String? state)? onCallState;
  final void Function(String url)? onPageFinished;

  const Callbacks({this.onCallState, this.onPageFinished});

  void addJavascriptHandlers(controller){
    if (onCallState != null) {
      controller?.addJavaScriptHandler(
          handlerName: 'CallState',
          callback: (args) {
            onCallState?.call(args.firstOrNull);
          }
      );
    }
  }

}
