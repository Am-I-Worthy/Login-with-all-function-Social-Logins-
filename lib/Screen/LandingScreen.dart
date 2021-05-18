import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_page_all_func/Screen/Login.dart';
import 'package:login_page_all_func/Screen/Register.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isRegisterScreen = false;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _pageController.addListener(() {
      setState(() {
        if (_pageController.page.round() == 0)
          isRegisterScreen = false;
        else
          isRegisterScreen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                LoginPage(
                  onCreateAccountClick: () {
                    setState(() {
                      _pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 575),
                        curve: Curves.ease,
                      );
                    });
                  },
                ),
                RegisterPage(
                  onLoginClicked: () {
                    setState(() {
                      _pageController.animateToPage(
                        0,
                        duration: Duration(milliseconds: 575),
                        curve: Curves.ease,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1620393470010-fd62b8ab841d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                ),
                Center(
                  child: Container(
                    height: 400.0,
                    width: 600.0,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(30.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          AnimatedCrossFade(
                              firstChild: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  'Welcome Back!',
                                  style: GoogleFonts.kaushanScript(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              secondChild: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Hey New One!",
                                  style: GoogleFonts.kaushanScript(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              crossFadeState: !isRegisterScreen
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: Duration(milliseconds: 300)),
                          AnimatedCrossFade(
                              firstChild: Text(
                                'Just LOG IN to open your Door to Knowledge',
                                style: GoogleFonts.kaushanScript(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              secondChild: Text(
                                'Just go ahead and do it like your Life depends on it.',
                                style: GoogleFonts.kaushanScript(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              crossFadeState: !isRegisterScreen
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: Duration(milliseconds: 300)),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'amiworthy.in',
                              style: GoogleFonts.montserrat(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
