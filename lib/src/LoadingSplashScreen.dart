import 'package:flutter/material.dart';

class LoadingSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Am I Worthy',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
