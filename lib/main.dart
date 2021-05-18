import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_page_all_func/Screen/LandingScreen.dart';
import 'package:login_page_all_func/src/ErrorPage.dart';
import 'package:login_page_all_func/src/LoadingSplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorPage();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return LandingScreen();
            }
            return LoadingSplashScreen();
          },
        ),
      ),
    );
  }
}
