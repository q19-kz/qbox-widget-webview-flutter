# Permissions

1) Микрофон и камера
Для работы аудио/видеозвонков

2) Загрузка и скачивание медиафайлов
Для обмена медиафайлами в текстовом чате требуются разрешения к хранилищу

## iOS

Нужно заполнить <project>/ios/Runner/Info.plist

```xml

<dict>
    <key>NSMicrophoneUsageDescription</key>
    <string>Ваш текст для запроса разрешения микрофона</string>
    <key>NSCameraUsageDescription</key>
    <string>Ваш текст для запроса разрешения камеры</string>
</dict>
```

## Android

Нужно заполнить <project>/android/app/src/main/AndroidManifest.xml

```xml

<manifest>
    <!-- Camera/microphone feature -->
    <uses-feature android:name="android.hardware.camera" />
    <uses-feature android:name="android.hardware.camera.autofocus" />
    <uses-feature android:name="android.hardware.microphone" />

    <!-- Camera/microphone permissions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.AUDIO_CAPTURE" />
    <uses-permission android:name="android.permission.VIDEO_CAPTURE" />

    <!-- Storage permissions -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"
        android:maxSdkVersion="32" />
    <!-- Devices running Android 13 (API level 33) or higher -->
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

    <!-- Devices running Android 13 (API level 33) or higher -->
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
    <uses-permission android:name="android.permission.READ_MEDIA_VIDEO" />

    <!-- To handle the reselection within the app on Android 14 (API level 34) -->
    <uses-permission android:name="android.permission.READ_MEDIA_VISUAL_USER_SELECTED" />
</manifest>
```
