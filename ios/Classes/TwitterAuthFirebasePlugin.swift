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
                  result(["error":"Error occurred - unable to get credentials."]);
              }
              if credential != nil {
                  Auth.auth().signIn(with: credential!)
                  { authResult, error in
                  if error != nil {
                      result(["success":false, "message": "Error occurred while signing in."]);
                  }
                  var authCredential = (authResult?.credential as? OAuthCredential)
                      if(authCredential == nil){
                          result(["success":false, "message":"Unable to resolve auth credential."]);
                      }else{
                          var response = [String: Any]()
//                          response["profile"] = authResult?.additionalUserInfo?.profile
                          response["idToken"] = authCredential!.idToken
                          response["accessToken"] = authCredential!.accessToken
                          response["success"] = true
                          response["message"] = "Successfully logged in"
                          result(response)
                      }
                     
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
