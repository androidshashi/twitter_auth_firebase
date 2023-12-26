import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'twitter_auth_firebase_platform_interface.dart';

/// An implementation of [TwitterAuthFirebasePlatform] that uses method channels.
class MethodChannelTwitterAuthFirebase extends TwitterAuthFirebasePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('twitter_auth_firebase');

  @override
  Future<Map<Object?, Object?>> loginViaTwitter() async {
    try {
      final result = await methodChannel
          .invokeMethod<Map<Object?, Object?>>('loginViaTwitter');
      log("=====================loginViaTwitter[SUCCESS]::==========================\n$result");
      return result ?? {};
    } on PlatformException catch (e) {
      log("=====================loginViaTwitter[ERROR]::==========================\n$e");
      return {};
    }
  }
}
