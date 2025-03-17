import 'package:flutter/material.dart';
import 'package:qbox_widget_webview/index.dart' as qbox;

void main() {
  runApp(const MyApp());
}

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

  @override
  void initState() {
    qboxWidget = qbox.WebWidget(
      const qbox.Settings(
        url: '<base url>',
        language: qbox.Language.ru,
        call: qbox.Call(
          domain: 'test.kz',
          topic: 'test',
          dynamicAttrs: {'foo': 'bar'},
        ),
        loggingEnabled: false,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: qboxWidget.build(),
    );
  }
}
