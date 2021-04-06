import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_art/generative_art.dart';

void main() {
  const MethodChannel channel = MethodChannel('generative_art');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await GenerativeArt.platformVersion, '42');
  });
}
