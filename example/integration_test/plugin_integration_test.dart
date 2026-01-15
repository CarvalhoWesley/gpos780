// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:gpos780/gpos780.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Gpos780 E2E Tests', () {
    testWidgets('init printer test', (WidgetTester tester) async {
      final String? result = await Gpos780.printer.init();
      expect(result, 'Impressora inicializada');
    });

    testWidgets('printText test', (WidgetTester tester) async {
      await Gpos780.printer.init();
      final String? result = await Gpos780.printer.printText(text: 'Integration Test');
      expect(result, 'Texto impresso com sucesso');
    });

    testWidgets('printMultipleLines test', (WidgetTester tester) async {
      await Gpos780.printer.init();
      final String? result = await Gpos780.printer.printMultipleLines(
        lines: ['Line 1', 'Line 2'],
      );
      expect(result, 'Múltiplas linhas impressas com sucesso');
    });

    testWidgets('printImageFromBase64 test', (WidgetTester tester) async {
      await Gpos780.printer.init();
      // This is a dummy base64 string. Replace with a small, valid base64 image string for a real test.
      const String base64Image =
          'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=';
      final String? result = await Gpos780.printer.printImageFromBase64(
        base64: base64Image,
      );
      expect(result, 'Imagem impressa com sucesso');
    });

    testWidgets('printImageFromBytes test', (WidgetTester tester) async {
      await Gpos780.printer.init();
      // This is a dummy byte array. Replace with valid image bytes for a real test.
      final Uint8List bytes = Uint8List.fromList([
        0x89,
        0x50,
        0x4e,
        0x47,
        0x0d,
        0x0a,
        0x1a,
        0x0a,
        0x00,
        0x00,
        0x00,
        0x0d,
        0x49,
        0x48,
        0x44,
        0x52,
        0x00,
        0x00,
        0x00,
        0x01,
        0x00,
        0x00,
        0x00,
        0x01,
        0x08,
        0x06,
        0x00,
        0x00,
        0x00,
        0x1f,
        0x15,
        0xc4,
        0x89,
        0x00,
        0x00,
        0x00,
        0x0a,
        0x49,
        0x44,
        0x41,
        0x54,
        0x78,
        0x9c,
        0x63,
        0x00,
        0x01,
        0x00,
        0x00,
        0x05,
        0x00,
        0x01,
        0x0d,
        0x0a,
        0x2d,
        0xb4,
        0x00,
        0x00,
        0x00,
        0x00,
        0x49,
        0x45,
        0x4e,
        0x44,
        0xae,
        0x42,
        0x60,
        0x82,
      ]);
      final String? result = await Gpos780.printer.printImageFromBytes(bytes: bytes);
      expect(result, 'Imagem impressa com sucesso');
    });

    testWidgets('printHtml test', (WidgetTester tester) async {
      await Gpos780.printer.init();
      final String? result = await Gpos780.printer.printHtml(html: '<h3>HTML Test</h3>');
      expect(result, 'HTML impresso com sucesso');
    });

    testWidgets('scrollPaper test', (WidgetTester tester) async {
      await Gpos780.printer.init();
      final String? result = await Gpos780.printer.scrollPaper(lines: 20);
      expect(result, 'Papel enrolado com sucesso');
    });
  });
}
