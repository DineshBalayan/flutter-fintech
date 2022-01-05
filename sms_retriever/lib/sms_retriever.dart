import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class SmsRetriever {
  static const MethodChannel _channel = const MethodChannel('sms_retriever');

  static Future<String> startListening() async {
    final String smsCode = await _channel.invokeMethod('startListening');
    return smsCode;
  }

  static Future<void> stopListening() async {
    await _channel.invokeMethod('stopListening');
    return;
  }

  static Future<String> getAppSignature() async {
    final String smsCode = await _channel.invokeMethod('getAppSignature');
    return smsCode;
  }

  static Future<String> getPhoneNumber() async {
    final String smsCode = await _channel.invokeMethod('requestPhoneHint');
    return smsCode;
  }

  static Future<int> hasLocationPermission() async {
    final int result = await _channel.invokeMethod('checkPermissions');
    return result;
  }

  static Future<int> hasCameraPermission() async {
    final int result = await _channel.invokeMethod('hasCameraPermission');
    return result;
  }

  static Future<int> hasContactPermission() async {
    if (Platform.isIOS) {
      return 1;
    }
    final int result = await _channel.invokeMethod('hasContactPermission');
    return result;
  }

  static Future<void> shareToWhatsApp(path, text) async {
    final bool result = await _channel.invokeMethod(
        'shareToWhatsApp', <String, Object>{'path': path, 'text': text});
    return;
  }

  static Future<String> unlockApp() async {
    if (Platform.isIOS) {
      return "true";
    }
    final String result = await _channel.invokeMethod('unlockApp');
    return result;
  }

  static Future<bool> isDeviceLocked() async {
    if (Platform.isIOS) {
      return false;
    }
    final bool result = await _channel.invokeMethod('isDeviceLocked');
    return result;
  }

  static Future<bool> keepScreenOn(bool turnOn) async {
    final bool result = await _channel
        .invokeMethod('keepScreenOn', <String, Object>{'turnOn': turnOn});
    return result;
  }
}
