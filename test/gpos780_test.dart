import 'package:flutter_test/flutter_test.dart';
import 'package:gpos780/gpos780.dart';
import 'package:gpos780/gpos780_platform_interface.dart';
import 'package:gpos780/gpos780_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'dart:typed_data';

class MockGpos780Platform
    with MockPlatformInterfaceMixin
    implements Gpos780Platform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> initPrinter() => Future.value('Printer Initialized');

  @override
  Future<String?> printHtml({required String html}) =>
      Future.value('HTML Printed');

  @override
  Future<String?> printImageFromBase64({required String base64}) =>
      Future.value('Image Printed');

  @override
  Future<String?> printImageFromBytes({required Uint8List bytes}) =>
      Future.value('Image Printed');

  @override
  Future<String?> printMultipleLines({
    required List<String> lines,
    String alignment = 'LEFT',
  }) => Future.value('Lines Printed');

  @override
  Future<String?> printText({
    required String text,
    int fontSize = 30,
    bool isBold = false,
    bool isUnderscore = false,
    String alignment = 'CENTER',
    int lineSpacing = 6,
  }) => Future.value('Text Printed');

  @override
  Future<String?> scrollPaper({int lines = 100}) =>
      Future.value('Paper Scrolled');
}

void main() {
  final Gpos780Platform initialPlatform = Gpos780Platform.instance;
  late MockGpos780Platform fakePlatform;

  setUp(() {
    fakePlatform = MockGpos780Platform();
    Gpos780Platform.instance = fakePlatform;
  });

  tearDown(() {
    Gpos780Platform.instance = initialPlatform;
  });

  test('$MethodChannelGpos780 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGpos780>());
  });

  test('getPlatformVersion', () async {
    expect(await Gpos780.printer.getPlatformVersion(), '42');
  });

  test('init printer', () async {
    expect(await Gpos780.printer.init(), 'Printer Initialized');
  });

  test('printText', () async {
    expect(await Gpos780.printer.printText(text: 'Test'), 'Text Printed');
  });

  test('printMultipleLines', () async {
    expect(
      await Gpos780.printer.printMultipleLines(lines: ['Line 1', 'Line 2']),
      'Lines Printed',
    );
  });

  test('printImageFromBase64', () async {
    expect(
      await Gpos780.printer.printImageFromBase64(base64: 'base64string'),
      'Image Printed',
    );
  });

  test('printImageFromBytes', () async {
    expect(
      await Gpos780.printer.printImageFromBytes(bytes: Uint8List(0)),
      'Image Printed',
    );
  });

  test('printHtml', () async {
    expect(
      await Gpos780.printer.printHtml(html: '<html></html>'),
      'HTML Printed',
    );
  });

  test('scrollPaper', () async {
    expect(await Gpos780.printer.scrollPaper(lines: 50), 'Paper Scrolled');
  });
}
