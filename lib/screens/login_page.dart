import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobile_fullstack/providers/auth.dart';
import 'package:todo_mobile_fullstack/screens/main_page.dart';
import 'package:todo_mobile_fullstack/utils/http_exception.dart';
import 'package:todo_mobile_fullstack/widgets/buttons.dart';
import 'package:todo_mobile_fullstack/widgets/forms.dart';
import 'package:todo_mobile_fullstack/widgets/inputs.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool keyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: LoginHeader(),
          ),
          Expanded(
            flex: 6,
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
        child: isLogin
            ? SignInSignUpForm(
                formKey: _loginFormKey,
                isSignIn: true,
                changePage: () {
                  setState(() {
                    isLogin = false;
                  });
                },
                loggedIn: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ));
                },
              )
            : SignInSignUpForm(
                formKey: _signUpFormKey,
                isSignIn: false,
                changePage: () {
                  setState(() {
                    isLogin = true;
                  });
                },
                loggedIn: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ));
                },
              ),
      ),
    );
  }
}
