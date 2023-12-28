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
            
              //Check if any error
              if error != nil {
                // Handle error.
                  result(["error":"Error occurred - unable to get credentials."]);
              }
              
              // Check if credential is not nil
              if credential != nil {
                  
                  // Sign in with credential
                  Auth.auth().signIn(with: credential!)
                  { authResult, error in
                      
                      // Check for any error while signing in with credentials
                      if error != nil {
                          result(["success":false, "message": "Error occurred while signing in."]);
                      }
                      
                      // Get id token of the current logged in user
                      authResult!.user.getIDToken { (idToken, error) in
                          
                             // Check for any error while getting idToken for the signed in user
                             if let error = error {
                                 result(["success":false, "message":"Unable to get id token"]);
                             }
                          
                             // Get oAuthCredentials
                              var oAuth = authResult?.credential as?  OAuthCredential
                             
                             // Check if oAuth is null or not
                              if(oAuth == nil){
                                  result(["success":false, "message":"Unable to resolve auth credential."]);
                              }
                             // Generate map or dictionary to send the response to the result callback
                          
                              var response = [String: Any]()
                              response["profile"] = authResult?.additionalUserInfo?.profile
                              response["idToken"] = idToken
                              response["accessToken"] = oAuth?.accessToken
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
