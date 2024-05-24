
Flutter webview wrapper for qbox web widget

## Usage
```dart
class _WebViewAppState extends State<WebViewApp> {
  late final qbox.WebWidget qboxWidget;

  @override
  void initState() {
    // Initialize widget with settings
    qboxWidget = qbox.WebWidget(
        const qbox.Settings(
            url: '<widget url>',
            language: qbox.Language.ru,
            call: qbox.Call(
                domain: '<domain>',
                topic: '<topic>'
            )
        )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your App'),
        ),
        // Add to your widget tree
        body: qboxWidget.build()
    );
  }
}   
```