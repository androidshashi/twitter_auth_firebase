// import 'package:flutter_test/flutter_test.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
// import 'package:twitter_auth_firebase/twitter_auth_firebase.dart';
// import 'package:twitter_auth_firebase/twitter_auth_firebase_method_channel.dart';
// import 'package:twitter_auth_firebase/twitter_auth_firebase_platform_interface.dart';
//
// class MockTwitterAuthFirebasePlatform
//     with MockPlatformInterfaceMixin
//     implements TwitterAuthFirebasePlatform {
//   @override
//   Future<String?> loginViaTwitter() => Future.value('42');
// }
//
// void main() {
//   final TwitterAuthFirebasePlatform initialPlatform =
//       TwitterAuthFirebasePlatform.instance;
//
//   test('$MethodChannelTwitterAuthFirebase is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelTwitterAuthFirebase>());
//   });
//
//   test('getPlatformVersion', () async {
//     TwitterAuthFirebase twitterAuthFirebasePlugin = TwitterAuthFirebase();
//     MockTwitterAuthFirebasePlatform fakePlatform =
//         MockTwitterAuthFirebasePlatform();
//     TwitterAuthFirebasePlatform.instance = fakePlatform;
//
//     expect(await twitterAuthFirebasePlugin.loginViaTwitter(), '42');
//   });
// }
