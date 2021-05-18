import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final UserCredential user;
  Home(this.user);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(user.user.displayName ?? ''),
                Text(user.user.email ?? ''),
                Text(user.user.uid ?? ''),
                Text(user.user.phoneNumber ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
