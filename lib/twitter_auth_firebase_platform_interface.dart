import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'twitter_auth_firebase_method_channel.dart';

abstract class TwitterAuthFirebasePlatform extends PlatformInterface {
  /// Constructs a TwitterAuthFirebasePlatform.
  TwitterAuthFirebasePlatform() : super(token: _token);

  static final Object _token = Object();

  static TwitterAuthFirebasePlatform _instance =
      MethodChannelTwitterAuthFirebase();

  /// The default instance of [TwitterAuthFirebasePlatform] to use.
  ///
  /// Defaults to [MethodChannelTwitterAuthFirebase].
  static TwitterAuthFirebasePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TwitterAuthFirebasePlatform] when
  /// they register themselves.
  static set instance(TwitterAuthFirebasePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<Object?, Object?>> loginViaTwitter() {
    throw UnimplementedError('loginViaTwitter() has not been implemented.');
  }
}
