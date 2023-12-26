import 'twitter_auth_firebase_platform_interface.dart';

class TwitterAuthFirebase {
  ///LOGIN USING TWITTER CREDENTIALS
  Future<Map<Object?, Object?>> loginViaTwitter() {
    return TwitterAuthFirebasePlatform.instance.loginViaTwitter();
  }
}
