import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:system/system.dart';

void main() {
  const MethodChannel channel = MethodChannel('system');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await System.platformVersion, '42');
  });
}
