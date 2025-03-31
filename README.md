# QBox Widget WebView

QBox Widget WebView is a lightweight Flutter package that enables seamless integration of QBox video and audio call widgets inside your Flutter apps using `InAppWebView`. It also includes automatic Picture-in-Picture (PiP) support and communication with the native Android layer via `MethodChannel`.

## 🚀 Features

✅ Simple integration of QBox video/audio calls in WebView  
✅ PiP (Picture-in-Picture) mode support for Android  
✅ Custom user/call configuration  
✅ Built-in WebView callbacks (progress, call state, etc.)  
✅ Supports communication with native Android code

## 📦 Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  qbox_widget_webview: ^0.3.4
```

Then run:

```sh
flutter pub get
```

## 🛠 Usage

### 1️⃣ Import the package:

```dart
import 'package:qbox_widget_webview/index.dart' as qbox;
```

### 2️⃣ Create and configure the `WebWidget`:

```dart
late final qbox.WebWidget qboxWidget;

@override
void initState() {
  qboxWidget = qbox.WebWidget(
    const qbox.Settings(
      url: '<base_url>',
      language: qbox.Language.ru,
      user: qbox.User(
        firstName: 'Johny',
        lastName: 'Apple',
        patronymic: 'Seed',
        iin: '112233445566',
        phoneNumber: '77771234567',
      ),
      call: qbox.Call(
        type: qbox.CallType.video,
        domain: 'test.kz',
        topic: 'test',
        dynamicAttrs: {'foo': 'bar'},
      ),
      loggingEnabled: false,
    ),
    qbox.Callbacks(
      onPageLoadProgress: (progress) => print('Progress: \$progress'),
      onPageLoadFinished: (url) => print('Loaded: \$url'),
      onCallState: (state) => print('Call State: \$state'),
    ),
  );
  super.initState();
}
```

### 3️⃣ Use the widget in your UI:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: qboxWidget.build(),
  );
}
```

## 🧩 Native Android Integration

To support bringing the app to the foreground after PiP mode is closed manually, add the following to your Android native `MainActivity.kt` file:

📁 `android/app/src/main/kotlin/com/example/your_app/MainActivity.kt`

```kotlin
package com.example.example // your channel


import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.pip.app/channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            if (call.method == "moveTaskToFront") {
                moveTaskToFront()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun moveTaskToFront() {
        val activityManager =
            getSystemService(Context.ACTIVITY_SERVICE) as android.app.ActivityManager
        activityManager.moveTaskToFront(taskId, 0)
    }
}
```

## 📜 License

This package is licensed under the MIT License.

## 🤝 Contributing

Feel free to contribute by submitting pull requests or issues.

## 💬 Support

If you have questions or issues, please open an issue on GitHub or contact the maintainer.

---

🚀 **Easily integrate QBox calls into your Flutter apps with `qbox_widget_webview`!**
