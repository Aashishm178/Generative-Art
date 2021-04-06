
import 'dart:async';

import 'package:flutter/services.dart';

class GenerativeArt {
  static const MethodChannel _channel =
      const MethodChannel('generative_art');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
