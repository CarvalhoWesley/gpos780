import 'dart:typed_data';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gpos780_method_channel.dart';

abstract class Gpos780Platform extends PlatformInterface {
  /// Constructs a Gpos780Platform.
  Gpos780Platform() : super(token: _token);

  static final Object _token = Object();

  static Gpos780Platform _instance = MethodChannelGpos780();

  /// The default instance of [Gpos780Platform] to use.
  ///
  /// Defaults to [MethodChannelGpos780].
  static Gpos780Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Gpos780Platform] when
  /// they register themselves.
  static set instance(Gpos780Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> initPrinter() {
    throw UnimplementedError('initPrinter() has not been implemented.');
  }

  Future<String?> printText({
    required String text,
    int fontSize = 30,
    bool isBold = false,
    bool isUnderscore = false,
    String alignment = 'CENTER',
    int lineSpacing = 6,
  }) {
    throw UnimplementedError('printText() has not been implemented.');
  }

  Future<String?> printMultipleLines({
    required List<String> lines,
    String alignment = 'LEFT',
  }) {
    throw UnimplementedError('printMultipleLines() has not been implemented.');
  }

  Future<String?> printImageFromBase64({required String base64}) {
    throw UnimplementedError(
      'printImageFromBase64() has not been implemented.',
    );
  }

  Future<String?> printImageFromBytes({required Uint8List bytes}) {
    throw UnimplementedError('printImageFromBytes() has not been implemented.');
  }

  Future<String?> printHtml({required String html}) {
    throw UnimplementedError('printHtml() has not been implemented.');
  }

  Future<String?> scrollPaper({int lines = 100}) {
    throw UnimplementedError('scrollPaper() has not been implemented.');
  }
}
