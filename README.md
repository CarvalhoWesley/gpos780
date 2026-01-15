# gpos780

[![Pub](https://img.shields.io/pub/v/gpos780.svg)](https://pub.dev/packages/gpos780)

A Flutter plugin for controlling the GPOS-780 thermal printer. This plugin provides a simple and intuitive interface to interact with the GPOS-780 printer on Android devices, supporting text printing, image printing, HTML rendering, and paper scrolling.

## Features

- 🖨️ **Text Printing** - Print formatted text with custom font size, bold, underline, and alignment options
- 🖼️ **Image Printing** - Print images from Base64 strings or raw bytes
- 📄 **Multiple Lines** - Print multiple lines with custom alignment
- 🌐 **HTML Support** - Print HTML content with formatting
- 📜 **Paper Control** - Scroll paper programmatically
- 🚀 **Static API** - Clean, intuitive static API design

## Supported Platforms

- Android (primary target)

## Installation

Add `gpos780` to your `pubspec.yaml`:

```yaml
dependencies:
  gpos780: ^2.1.4
```

Then run:

```bash
flutter pub get
```

## Usage

### Initialize the Printer

```dart
import 'package:gpos780/gpos780.dart';

// Initialize the printer
await Gpos780.printer.init();
```

### Print Text

```dart
await Gpos780.printer.printText(
  text: 'Hello, World!',
  fontSize: 30,
  isBold: true,
  alignment: 'CENTER',
  lineSpacing: 6,
);
```

**Parameters:**
- `text` (required): The text to print
- `fontSize`: Font size (default: 30)
- `isBold`: Enable bold text (default: false)
- `isUnderscore`: Enable underline (default: false)
- `alignment`: Text alignment - 'LEFT', 'CENTER', 'RIGHT' (default: 'CENTER')
- `lineSpacing`: Space between lines (default: 6)

### Print Multiple Lines

```dart
await Gpos780.printer.printMultipleLines(
  lines: ['Line 1', 'Line 2', 'Line 3'],
  alignment: 'LEFT',
);
```

**Parameters:**
- `lines` (required): List of text lines to print
- `alignment`: Text alignment - 'LEFT', 'CENTER', 'RIGHT' (default: 'LEFT')

### Print Images

#### From Base64 String

```dart
const String base64Image = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=';

await Gpos780.printer.printImageFromBase64(base64: base64Image);
```

#### From Bytes

```dart
import 'dart:typed_data';

final Uint8List imageBytes = // ... your image bytes
await Gpos780.printer.printImageFromBytes(bytes: imageBytes);
```

### Print HTML

```dart
await Gpos780.printer.printHtml(html: '<h1>Title</h1><p>This is a test</p>');
```

### Scroll Paper

```dart
// Scroll the paper by 100 lines
await Gpos780.printer.scrollPaper(lines: 100);
```

### Get Platform Version

```dart
final String? platformVersion = await Gpos780.printer.getPlatformVersion();
print('Platform: $platformVersion');
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:gpos780/gpos780.dart';
import 'dart:typed_data';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize printer
  await Gpos780.printer.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('GPOS-780 Printer')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.printText(
                    text: 'Hello GPOS-780!',
                    fontSize: 30,
                    isBold: true,
                    alignment: 'CENTER',
                  );
                },
                child: const Text('Print Text'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.printMultipleLines(
                    lines: ['Line 1', 'Line 2', 'Line 3'],
                  );
                },
                child: const Text('Print Lines'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.printHtml(
                    html: '<h1>HTML Content</h1>',
                  );
                },
                child: const Text('Print HTML'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Gpos780.printer.scrollPaper(lines: 50);
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
```

## Error Handling

All plugin methods are asynchronous and return `Future<String?>`. Always handle potential errors:

```dart
try {
  final result = await Gpos780.printer.printText(text: 'Test');
  if (result != null) {
    print('Success: $result');
  }
} catch (e) {
  print('Error: $e');
}
```

## Architecture

The plugin follows a modular architecture using a static API pattern:

```dart
Gpos780.printer    // Printer module
// Future additions:
// Gpos780.nfc      // NFC module
// Gpos780.barcode  // Barcode module
```

This design allows for easy expansion of functionality while maintaining a clean, intuitive API.

## Requirements

- Flutter 2.0 or higher
- Android API level 21 or higher
- GPOS-780 compatible device

## Contributing

Contributions are welcome! Please feel free to open issues or submit pull requests.

## License

This plugin is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Support

For issues, questions, or suggestions, please open an issue on the GitHub repository.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes in each release.

