import 'package:community/addpost.dart';
import 'package:community/home.dart';
import 'package:community/login.dart';
import 'package:community/myposts.dart';
import 'package:community/noconnection.dart';
import 'package:community/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "register": (context) => RegisterScreen(),
        "login": (context) => LoginScreen(),
        "home": (context) => HomeScreen(),
        "addpost": (context) => AddPostScreen(),
        "myposts": (context) => MyPostsScreen(),
      },
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, db) {
            if (db.connectionState == ConnectionState.active ||
                db.connectionState == ConnectionState.done) {
              return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, authstate) {
                    if (authstate.hasData) {
                      return HomeScreen();
                    } else {
                      return LoginScreen();
                    }
                  });
            } else {
              return NoConnectoin();
            }
          }),
    );
  }
}
