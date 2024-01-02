import 'twitter_auth_firebase_platform_interface.dart';

/// TwitterAuthFirebase contains loginViaTwitter method to provide login feature via firebase
class TwitterAuthFirebase {
  /// Login with twitter ... in result this returns all the required values
  /// In case of success this method returns
  ///
  /// {
  ///  "success": true,
  ///  "message": "Got the data",
  ///  "profile": {} , //Profile data of the twitter user
  ///  "IdToken": "fakfakhfdayoyewoo",
  ///  "accessToken" : "jadfafshalsfhlahsflhas"
  /// }
  ///
  /// In case of error this method returns
  ///
  /// {
  ///  "success": false,
  ///  "message": "Some error occurred",
  ///  "error":{} // Error data
  /// }
  static Future<Map<Object?, Object?>> loginViaTwitter() {
    return TwitterAuthFirebasePlatform.instance.loginViaTwitter();
  }
}
