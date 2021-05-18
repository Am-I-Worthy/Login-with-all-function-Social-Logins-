import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final Function onLoginClicked;
  RegisterPage({
    this.onLoginClicked,
  });
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserCredential userCredential;
  TextEditingController _emailEditingController;
  TextEditingController _passwordEditingController;

  String email;
  String password;
  bool isSigning = false;
  String errorString;

  @override
  void initState() {
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    errorString = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Am I ',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: 'Worthy',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue[400],
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Text(
            'Sign Up',
            style: GoogleFonts.montserrat(
              fontSize: 33.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Please enter your credentials',
            style: GoogleFonts.montserrat(
              fontSize: 12.0,
              color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Flexible(
            child: TextField(
              controller: _emailEditingController,
              decoration: _inputDecoration('Enter the email'),
              onChanged: (value) {
                email = value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Flexible(
            child: TextField(
              controller: _passwordEditingController,
              obscureText: true,
              decoration: _inputDecoration('Enter your password'),
              onChanged: (value) {
                password = value;
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          AnimatedContainer(
            margin: EdgeInsets.only(bottom: 10.0),
            duration: Duration(milliseconds: 375),
            width: errorString == null ? 0.0 : 300.0,
            height: errorString == null ? 0.0 : 16.0,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 475),
              opacity: errorString == null ? 0.0 : 1.0,
              child: Text(
                errorString ?? '',
                softWrap: false,
                style: GoogleFonts.quicksand(
                  color: Colors.red,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          !isSigning
              ? TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: Colors.white,
                    backgroundColor: Colors.blue[400],
                    padding: EdgeInsets.symmetric(
                      horizontal: 80.0,
                      vertical: 20.0,
                    ),
                  ),
                  onPressed: () {
                    _register();
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                )
              : Container(
                  height: 30.0,
                  width: 30.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          SizedBox(
            height: 40.0,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an Account?',
                style: GoogleFonts.quicksand(
                  color: Colors.black54,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  primary: Colors.blue[400],
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 2.0,
                  ),
                ),
                onPressed: () {
                  widget.onLoginClicked();
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _register() async {
    setState(() {
      isSigning = true;
    });
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorString = 'The password provided is too weak.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorString = 'The account already exists for that email.';
        print('Account already exists for that email.');
      } else {
        errorString = e.code;
        print(e.code);
      }

      Future.delayed(Duration(milliseconds: 3000), () {
        setState(() {
          errorString = null;
        });
      });
    }
    setState(() {
      isSigning = false;
      _emailEditingController.clear();
      _passwordEditingController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.black38,
        fontSize: 13.0,
        fontWeight: FontWeight.w600,
      ),
      fillColor: Color(0xfff6f7f8),
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
