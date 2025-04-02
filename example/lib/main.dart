import 'package:flutter/material.dart';
import 'package:qbox_widget_webview/index.dart' as qbox;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: const MyHomePage(title: 'Example'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final qbox.WebWidget qboxWidget;

  String? pipState;

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
          type: qbox.CallType.video, // audio = qbox.CallType.audio
          domain: 'test.kz',
          topic: 'test',
          dynamicAttrs: {'foo': 'bar'},
        ),
        loggingEnabled: false,
      ),
      qbox.Callbacks(
        onPageLoadProgress: (progress) {
          debugPrint('onPageLoadProgress: $progress');
        },
        onPageLoadFinished: (url) {
          debugPrint('onPageLoadFinished: $url');
        },
        onCallState: (String state) {
          debugPrint('onCallState: $state');
        },
        onPiPState: (String state) {
          debugPrint('onPiPState: $state');
          setState(() {
            pipState = state;
          });
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          pipState == null || pipState == 'exited'
              ? AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(widget.title),
              )
              : null,
      body: qboxWidget,
    );
  }
}
