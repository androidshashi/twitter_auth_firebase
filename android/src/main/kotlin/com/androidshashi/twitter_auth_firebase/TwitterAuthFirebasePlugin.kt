package com.androidshashi.twitter_auth_firebase

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TwitterAuthFirebasePlugin */
class TwitterAuthFirebasePlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private val CHANNEL = "twitter_auth_firebase"
  private val provider = OAuthProvider.newBuilder("twitter.com")
  private var firebaseAuth: FirebaseAuth? = null
  private var pendingResultTask : Task<AuthResult>? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL)
    channel.setMethodCallHandler(this)
    configFirebase();
  }

   fun configFirebase() {
    FirebaseApp.initializeApp(applicationContext)
    firebaseAuth = FirebaseAuth.getInstance()
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "loginViaTwitter") {
      twitter {
        //result.success("Success");
        if (it["success"] as Boolean){
          result.success(it)
        }else{
          result.error(it["success"].toString(), it["message"].toString(), it["error"].toString())
        }
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  private fun twitter(callBack: (Map<String, Any?>)->Unit){

    if (pendingResultTask != null) {
      // There's something already here! Finish the sign-in for your user.
      pendingResultTask
        ?.addOnSuccessListener {
          buildResult(it){map->
            callBack(map)
          }

        }
        ?.addOnFailureListener {
          val map =  mutableMapOf<String,Any?>()
          // Handle failure.
          map["success"] = false
          map["message"] = it.message
          map["error"] = it.toString()
          callBack(map)
        }
    } else {
      pendingResultTask =   firebaseAuth
        ?.startActivityForSignInWithProvider(this, provider.build())
        ?.addOnSuccessListener {
          buildResult(it){map->
            callBack(map)
          }
        }
        ?.addOnFailureListener {
          val map =  mutableMapOf<String,Any?>()
          // Handle failure.
          Log.d("twitter", "${it.message}")
          map["success"] = false
          map["message"] = it.message
          map["error"] = it.toString()
          callBack(map)
        }
    }

  }

  private fun buildResult(authResult: AuthResult, onTokenReceived:(Map<String, Any?>)->Unit){
    val map =  mutableMapOf<String,Any?>()
    // User is signed in.
    // IdP data available in
    Log.d("twitter", "============================")
    authResult.user?.getIdToken(true)?.addOnCompleteListener {

      if(it.isComplete){
        val idToken : String? = it.result.token
        Log.d("twitter", "Id Token::$idToken")
        Log.d("twitter", "Access Token::${((authResult.credential) as OAuthCredential).accessToken}")
        Log.d("twitter", "============================")
        map["profile"] = authResult.additionalUserInfo?.profile.toString()
        map["idToken"] = idToken
        map["accessToken"] = ((authResult.credential) as OAuthCredential).accessToken.toString()
        map["success"] = true
        map["message"] = "Got the data"
        onTokenReceived(map)
      }
    }

  }
}
