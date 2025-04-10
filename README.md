<!--suppress CheckImageSize -->
<img src="assets/image/logo.png" alt="19" width="150" height="150">

# QBox Widget WebView

## 🚀 Features

✅ Simple integration of QBox text/audio/video calls in WebView  
✅ PiP (Picture-in-Picture) mode support for Android  
✅ Custom user/call configuration  
✅ Built-in WebView callbacks (progress, call state, etc.)

## 📦 Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  qbox_widget_webview: ^0.3.7
```

Then run:

```sh
flutter pub get
```

[Permissions](docs/permissions.md)

[Listener](docs/listener.md)

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
    body: qboxWidget,
  );
}
```

## 🧩 Native Android Integration

Declare PiP support

📁 `android/app/src/main/kotlin/com/example/your_app/src/main/AndroidManifest.xml`

```xml
<activity 
    android:name="MainActivity" 
    android:supportsPictureInPicture="true"
    android:configChanges="screenSize|smallestScreenSize|screenLayout|orientation"
/>
```

To support bringing the app to the foreground after PiP mode is closed manually, add the following
to your Android native `MainActivity.kt` file:

📁 `android/app/src/main/kotlin/com/example/your_app/MainActivity.kt`

```kotlin
package com.example.example // your package

import cl.puntito.simple_pip_mode.PipCallbackHelperActivityWrapper

class MainActivity : PipCallbackHelperActivityWrapper()
```
