
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
            url: 'https://inqbox.q19.kz/wc/',
            language: qbox.Language.ru,
            call: qbox.Call(
                domain: 'dev.test.kz',
                topic: 'sos_test_free'
            )
        )
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
        ),
        // Add to your widget tree
        body: qboxWidget.build()
    );
  }
}   
```