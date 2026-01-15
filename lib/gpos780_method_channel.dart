import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gpos780_platform_interface.dart';

/// An implementation of [Gpos780Platform] that uses method channels.
class MethodChannelGpos780 extends Gpos780Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gpos780');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<String?> initPrinter() async {
    return await methodChannel.invokeMethod<String>('initPrinter');
  }

  @override
  Future<String?> printText({
    required String text,
    int fontSize = 30,
    bool isBold = false,
    bool isUnderscore = false,
    String alignment = 'CENTER',
    int lineSpacing = 6,
  }) async {
    return await methodChannel.invokeMethod<String>('printText', {
      'text': text,
      'fontSize': fontSize,
      'isBold': isBold,
      'isUnderscore': isUnderscore,
      'alignment': alignment,
      'lineSpacing': lineSpacing,
    });
  }

  @override
  Future<String?> printMultipleLines({
    required List<String> lines,
    String alignment = 'LEFT',
  }) async {
    return await methodChannel.invokeMethod<String>('printMultipleLines', {
      'lines': lines,
      'alignment': alignment,
    });
  }

  @override
  Future<String?> printImageFromBase64({required String base64}) async {
    return await methodChannel.invokeMethod<String>('printImageFromBase64', {
      'base64': base64,
    });
  }

  @override
  Future<String?> printImageFromBytes({required Uint8List bytes}) async {
    return await methodChannel.invokeMethod<String>('printImageFromBytes', {
      'bytes': bytes,
    });
  }

  @override
  Future<String?> printHtml({required String html}) async {
    return await methodChannel.invokeMethod<String>('printHtml', {
      'html': html,
    });
  }

  @override
  Future<String?> scrollPaper({int lines = 100}) async {
    return await methodChannel.invokeMethod<String>('scrollPaper', {
      'lines': lines,
    });
  }
}
