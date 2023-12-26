import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_auth_firebase/twitter_auth_firebase_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTwitterAuthFirebase platform =
      MethodChannelTwitterAuthFirebase();
  const MethodChannel channel = MethodChannel('twitter_auth_firebase');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.loginViaTwitter(), '42');
  });
}
