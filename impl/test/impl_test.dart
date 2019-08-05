import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impl/impl.dart';

void main() {
  const MethodChannel channel = MethodChannel('impl');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Impl.platformVersion, '42');
  });
}
