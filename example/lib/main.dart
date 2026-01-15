import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:gpos780/gpos780.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await Gpos780.printer.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.init();
                },
                child: const Text('Init Printer'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.printText(text: 'Hello World');
                },
                child: const Text('Print Text'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.printMultipleLines(
                    lines: ['Line 1', 'Line 2', 'Line 3'],
                  );
                },
                child: const Text('Print Multiple Lines'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Replace with a valid base64 image
                  await Gpos780.printer.printImageFromBase64(base64: '');
                },
                child: const Text('Print Image from Base64'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Replace with valid image bytes
                  await Gpos780.printer.printImageFromBytes(
                    bytes: Uint8List(0),
                  );
                },
                child: const Text('Print Image from Bytes'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.printHtml(html: '<h1>Hello World</h1>');
                },
                child: const Text('Print HTML'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.scrollPaper(lines: 100);
                },
                child: const Text('Scroll Paper'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
