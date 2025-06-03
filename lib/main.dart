import 'package:community/home.dart';
import 'package:community/login.dart';
import 'package:community/register.dart';
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
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // snapshot.connectionState == ConnectionState.active
        return MaterialApp(
          title: 'Flutter Demo',
          initialRoute: "register",
          routes: {
            "register":(context)=>RegisterScreen(),
            "login":(context)=>LoginScreen(),
            "home":(context)=>HomeScreen()
          },
        );
      }
    );
  }
}
