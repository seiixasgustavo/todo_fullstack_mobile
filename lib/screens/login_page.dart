import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:todo_mobile_fullstack/screens/main_page.dart';
import 'package:todo_mobile_fullstack/widgets/buttons.dart';
import 'package:todo_mobile_fullstack/widgets/forms.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool keyboardVisible = false;

  @protected
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          keyboardVisible = visible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          !keyboardVisible
              ? Expanded(
                  flex: 2,
                  child: LoginHeader(),
                )
              : SafeArea(bottom: false, child: Container()),
          Expanded(
            flex: !keyboardVisible ? 3 : 1,
            child: LoginBody(),
          ),
        ],
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey[800],
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey[900],
                              offset: Offset(3, 4),
                              blurRadius: 2)
                        ],
                      ),
                    ),
                    Text(
                      "Back!",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(
                              color: Colors.grey[900],
                              offset: Offset(3, 4),
                              blurRadius: 2)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  "images/login.svg",
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey();
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Color(0xFF202020),
      ),
      child: SafeArea(
        top: false,
        // child: isLogin
        //     ? SignInSignUpForm(
        //         formKey: _loginFormKey,
        //         isSignIn: true,
        //         changePage: () {
        //           setState(() {
        //             isLogin = false;
        //           });
        //         },
        //         loggedIn: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => MainPage(),
        //               ));
        //         },
        //       )
        //     : SignInSignUpForm(
        //         formKey: _signUpFormKey,
        //         isSignIn: false,
        //         changePage: () {
        //           setState(() {
        //             isLogin = true;
        //           });
        //         },
        //         loggedIn: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => MainPage(),
        //               ));
        //         },
        //       ),
        child: LoginPageInitialPage(),
      ),
    );
  }
}

class LoginPageInitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                        color: Colors.grey[800],
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        ActionButtonWithIcon(),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SignInGoogleButton(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SignInFacebookButton(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SizedBox(
            width: 100,
            height: 1,
            child: Container(
              color: Colors.grey,
            ),
          ),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "Don't have an account yet? ",
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
            TextSpan(
              text: "Sign Up!",
              style: TextStyle(color: Colors.blueAccent),
            )
          ]),
        ),
      ],
    );
  }
}
