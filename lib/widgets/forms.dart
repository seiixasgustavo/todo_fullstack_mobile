import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobile_fullstack/providers/auth.dart';
import 'package:todo_mobile_fullstack/providers/todos.dart';
import 'package:todo_mobile_fullstack/utils/http_exception.dart';
import 'package:todo_mobile_fullstack/widgets/buttons.dart';
import 'package:todo_mobile_fullstack/widgets/dialogs.dart';
import 'package:todo_mobile_fullstack/widgets/inputs.dart';

class SignInSignUpForm extends StatefulWidget {
  SignInSignUpForm({
    this.changePage,
    this.loggedIn,
    @required this.formKey,
    @required this.isSignIn,
  });

  final GlobalKey<FormState> formKey;

  final bool isSignIn;
  final Function loggedIn;
  final Function changePage;

  @override
  _SignInSignUpFormState createState() => _SignInSignUpFormState();
}

class _SignInSignUpFormState extends State<SignInSignUpForm> {
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  String name;
  String email;
  String password;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  void login() async {
    if (!widget.formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    widget.formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).login(email, password);
      await Provider.of<Todos>(context, listen: false).getAllTodos();
      widget.loggedIn();
    } on HttpException catch (_) {
      var errorMessage = 'Authentication Failed';
      showErrorDialog(context, errorMessage);
    } catch (_) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      showErrorDialog(context, errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void signUp() async {
    if (!widget.formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    widget.formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(name, password, email);
      try {
        await Provider.of<Auth>(context, listen: false).login(email, password);
        widget.loggedIn();
      } on HttpException {
        widget.changePage();
        var errorMessage = 'Authentication Failed';
        showErrorDialog(context, errorMessage);
      } catch (e) {
        widget.changePage();
        const errorMessage =
            'Could not authenticate you. Please try again later';
        showErrorDialog(context, errorMessage);
      }
    } on HttpException {
      var errorMessage = 'Sign Up Failed';
      showErrorDialog(context, errorMessage);
    } catch (e) {
      const errorMessage = 'Could not sign up you. Please try again later';
      showErrorDialog(context, errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
                        widget.isSignIn ? 'Sign In' : 'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            BoxShadow(
                              color: Colors.grey[800],
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            )
                          ],
                        ),
                      ),
                      if (!widget.isSignIn)
                        IconButton(
                          icon: Icon(FontAwesomeIcons.times),
                          onPressed: () {
                            _passwordController.clear();
                            widget.changePage();
                          },
                        )
                    ]),
              ),
            ),
            if (!widget.isSignIn)
              LoginInput(
                child: TextFormField(
                  onSaved: (newValue) {
                    name = newValue;
                  },
                  decoration: InputDecoration(
                    labelText: "Name...",
                    prefixIcon: Icon(FontAwesomeIcons.user),
                  ),
                ),
              ),
            LoginInput(
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) {
                  email = newValue;
                },
                decoration: InputDecoration(
                  labelText: "Email...",
                  prefixIcon: Icon(FontAwesomeIcons.envelope),
                ),
              ),
            ),
            LoginInput(
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (newValue) {
                  password = newValue;
                },
                decoration: InputDecoration(
                  labelText: "Password...",
                  prefixIcon: Icon(FontAwesomeIcons.lock),
                ),
              ),
            ),
            if (!widget.isSignIn)
              LoginInput(
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match!';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Confirm Password...",
                    prefixIcon: Icon(FontAwesomeIcons.lock),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: !_isLoading
                  ? ActionButton(
                      text: "Confirm",
                      onPressed: () {
                        if (widget.isSignIn) {
                          login();
                        } else {
                          signUp();
                        }
                      },
                    )
                  : SpinKitCircle(
                      size: 45.0,
                      color: Colors.blueAccent,
                    ),
            ),
            if (widget.isSignIn)
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: SizedBox(
                  width: 140,
                  height: 1,
                  child: Container(color: Colors.grey[700]),
                ),
              ),
            if (widget.isSignIn)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SignInGoogleButton(),
              ),
            if (widget.isSignIn)
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: RichText(
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _passwordController.clear();
                          widget.changePage();
                        },
                    )
                  ]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
