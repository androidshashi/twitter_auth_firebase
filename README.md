# Twitter Auth Firebase Plugin

## Overview

Twitter Auth Firebase is a Flutter plugin that simplifies Twitter authentication using Firebase. It seamlessly integrates with your Flutter application, enabling users to log in via Twitter with ease.

## Requirements

1. This plugin is compatible only with Twitter login through Firebase.
2. Flutter version: `>=3.3.0` and Dart SDK version: `>=3.1.5 <4.0.0`.
3. Firebase setup is necessary for Twitter authentication. Enable Twitter Auth in the Firebase Sign-In section.

## Features

1. **Easy Configuration:** Simple setup process for seamless integration.
2. **No Extra Keys:** No need for additional Twitter secret keys or callback URLs.
3. **Comprehensive User Data:** Provides all necessary data of the logged-in user.
4. **Minimal Setup:** No extra configuration needed beyond Firebase SDK in your iOS and Android apps.

## Getting Started

Find a detailed example in the `/example` directory.

Use the `TwitterAuthFirebase.loginViaTwitter()` method to initiate the authentication process:

```dart
final Map<Object?, Object?>? result = await TwitterAuthFirebase.loginViaTwitter();

bool? success = result["success"]; // Indicates success
String? message = result["message"]; // Message for success and error
Map<Object?, Object?>? profileData = result["profile"]; // User's Twitter profile data on success
String? idToken = result["idToken"]; // User's ID token
String? accessToken = result["accessToken"]; // User's access token
Map<Object?, Object?>? error = result["error"]; // Error object, if any
```
### About TwitterAuthFirebase class

  Attributes  | Desscription                                                                                                                                                     
------------- |------------------------------------------------------------------------------------------------------------------------------------------------------------------
| TwitterAuthFirebase  | A class that is having loginViaTwitter method.                                                                                                                   | 
| loginViaTwitter  | This method takes nothing and returns a Map<Object?, Object?>? that has all the required data.                                                                   | 


### loginViaTwitter method response

  Response  | Desscription                                                                                                                                                     
------------- |------------------------------------------------------------------------------------------------------------------------------------------------------------------
| bool? success  | If true its a success response                                                                                                                   | 
| String? message  | message for success and error |  
| Map<Object?, Object?>? profile  | if success it will have logged in user twitter profileData |  
| String? idToken  | idToken of the user |  
| String? accessToken  | access token of the user |  
| Map<Object?, Object?>? error  | error object if any  |  
