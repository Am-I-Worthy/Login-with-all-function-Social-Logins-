import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page_all_func/Screen/Home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  final Function onCreateAccountClick;
  LoginPage({
    this.onCreateAccountClick,
  });
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserCredential user;
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
            'Sign In',
            style: GoogleFonts.montserrat(
              fontSize: 35.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Please enter you login credentials',
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
            width: errorString == null ? 0.0 : 250.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              !isSigning
                  ? TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        primary: Colors.white,
                        backgroundColor: Colors.blue[400],
                        padding: EdgeInsets.symmetric(
                          horizontal: 90.0,
                          vertical: 20.0,
                        ),
                      ),
                      onPressed: () {
                        _login();
                      },
                      child: Text(
                        'Sign In',
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
              Flexible(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    primary: Colors.black54,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 2.0,
                    ),
                  ),
                  onPressed: () {
                    // _login();
                  },
                  child: Text(
                    'Forget Password?',
                    style: GoogleFonts.quicksand(),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: Text(
              'Or',
              style:
                  GoogleFonts.montserrat(fontSize: 12.0, color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Text(
              'Login With',
              style: GoogleFonts.montserrat(
                fontSize: 14.0,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Container(
              height: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  IconButton(
                      splashRadius: 25.0,
                      icon: Icon(
                        EvaIcons.google,
                      ),
                      onPressed: () async {
                        user = await signInWithGoogle();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(user),
                          ),
                        );
                      }),
                  SizedBox(
                    width: 20.0,
                  ),
                  IconButton(
                      splashRadius: 25.0,
                      icon: Icon(
                        EvaIcons.twitter,
                      ),
                      onPressed: () async {
                        user = await signInWithTwitter();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(user),
                          ),
                        );
                      }),
                  SizedBox(
                    width: 20.0,
                  ),
                  IconButton(
                      splashRadius: 25.0,
                      icon: Icon(
                        EvaIcons.facebook,
                      ),
                      onPressed: () async {
                        user = await signInWithFacebook();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(user),
                          ),
                        );
                      }),
                  SizedBox(
                    width: 20.0,
                  ),
                  IconButton(
                      splashRadius: 25.0,
                      icon: Icon(
                        EvaIcons.github,
                        // color: Colors.blue[400],
                      ),
                      onPressed: () async {
                        user = await signInWithGitHub();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(user),
                          ),
                        );
                      }),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an Account?',
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
                  widget.onCreateAccountClick();
                },
                child: Text(
                  'Create Account',
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

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  Future<UserCredential> signInWithTwitter() async {
    TwitterAuthProvider twitterProvider = TwitterAuthProvider();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(twitterProvider);
  }

  Future<UserCredential> signInWithFacebook() async {
    FacebookAuthProvider facebookProvider = FacebookAuthProvider();

    facebookProvider.addScope('email');
    facebookProvider.setCustomParameters({
      'display': 'popup',
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
  }

  Future<UserCredential> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(githubProvider);
  }

  void _login() async {
    setState(() {
      isSigning = true;
    });
    try {
      user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          errorString = 'No user found for that email.';
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          errorString = 'Wrong password provided for that user.';
          print('Wrong password provided for that user.');
        } else {
          errorString = e.code;
          print(e.code);
        }
      });

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
      hintStyle: GoogleFonts.quicksand(
        color: Colors.black38,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
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
