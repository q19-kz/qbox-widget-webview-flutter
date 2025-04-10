# Listener

При инициализации виджета вы можете передать callbacks

```dart
@override
void initState() {
  qboxWidget = qbox.WebWidget(
    //...
      qbox.Callbacks(
        onCallState: (state) {
          // print state
        },
        onPageLoadProgress: (progress) {
          // print progress
        },
        onPageLoadFinished: (url) {
          // print url
        },
        onDownloadFile: (url, [filename]) async {
          // call your downloader
        },
      )
  );
  super.initState();
}
```
