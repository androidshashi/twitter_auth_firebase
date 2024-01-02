import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter_auth_firebase/twitter_auth_firebase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<Object?, Object?> result = {};


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Twitter firebase plugin'),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: () async {
              try {
                result = await TwitterAuthFirebase.loginViaTwitter();
              } on PlatformException {
                result = {'Failed': 'Failed to get twitter auth'};
              }

              // If the widget was removed from the tree while the asynchronous platform
              // message was in flight, we want to discard the reply rather than calling
              // setState to update our non-existent appearance.
              if (!mounted) return;

              setState(() {});
            }, child: const Text('Twitter Auth')),
            Center(
              child: Text('Twitter auth result: $result'),
            ),
          ],
        ),
      ),
    );
  }
}
