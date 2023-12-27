import Flutter
import UIKit
import FirebaseAuth

public class TwitterAuthFirebasePlugin: NSObject, FlutterPlugin {


var provider = OAuthProvider(providerID: "twitter.com")

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "twitter_auth_firebase", binaryMessenger: registrar.messenger())
    let instance = TwitterAuthFirebasePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "loginViaTwitter":
        loginViaTwitter(result:result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    private func loginViaTwitter(result: @escaping FlutterResult){
        provider.getCredentialWith(nil) { credential, error in
              if error != nil {
                // Handle error.
                  result(["error":"Error occurred"]);
              }
              if credential != nil {
                  Auth.auth().signIn(with: credential!)
                  { authResult, error in
                  if error != nil {
                      result(["error":"Error in login occurred"]);
                  }
                      result(["success":(authResult?.credential as? OAuthCredential)?.accessToken]);
                  // User is signed in.
                  // IdP data available in authResult.additionalUserInfo.profile.
                  // Twitter OAuth access token can also be retrieved by:
                  // (authResult.credential as? OAuthCredential)?.accessToken
                  // Twitter OAuth ID token can be retrieved by calling:
                  // (authResult.credential as? OAuthCredential)?.idToken
                  // Twitter OAuth secret can be retrieved by calling:
                  // (authResult.credential as? OAuthCredential)?.secret
                }
              }
            }

    }
}
