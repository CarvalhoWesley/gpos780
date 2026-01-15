import 'dart:typed_data';

import 'gpos780_platform_interface.dart';

class Gpos780 {
  // Construtor privado para prevenir instanciação
  Gpos780._();

  /// Acesso aos métodos da impressora
  static final printer = _Printer();
  
  // Futuramente você pode adicionar:
  // static final nfc = _Nfc();
}

class _Printer {
  Future<String?> getPlatformVersion() {
    return Gpos780Platform.instance.getPlatformVersion();
  }

  Future<String?> init() {
    return Gpos780Platform.instance.initPrinter();
  }

  Future<String?> printText({
    required String text,
    int fontSize = 30,
    bool isBold = false,
    bool isUnderscore = false,
    String alignment = 'CENTER',
    int lineSpacing = 6,
  }) {
    return Gpos780Platform.instance.printText(
      text: text,
      fontSize: fontSize,
      isBold: isBold,
      isUnderscore: isUnderscore,
      alignment: alignment,
      lineSpacing: lineSpacing,
    );
  }

  Future<String?> printMultipleLines({
    required List<String> lines,
    String alignment = 'LEFT',
  }) {
    return Gpos780Platform.instance.printMultipleLines(
      lines: lines,
      alignment: alignment,
    );
  }

  Future<String?> printImageFromBase64({required String base64}) {
    return Gpos780Platform.instance.printImageFromBase64(base64: base64);
  }

  Future<String?> printImageFromBytes({required Uint8List bytes}) {
    return Gpos780Platform.instance.printImageFromBytes(bytes: bytes);
  }

  Future<String?> printHtml({required String html}) {
    return Gpos780Platform.instance.printHtml(html: html);
  }

  Future<String?> scrollPaper({int lines = 100}) {
    return Gpos780Platform.instance.scrollPaper(lines: lines);
  }
}
