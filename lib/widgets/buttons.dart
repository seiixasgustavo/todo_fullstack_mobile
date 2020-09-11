import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends StatelessWidget {
  ActionButton({@required this.text, @required this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onPressed();
      },
      color: Colors.blueAccent,
      child: Container(
        width: 180,
        height: 45,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SignInGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.blueAccent),
      onPressed: () {},
      child: Container(
        width: 180,
        height: 45,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "images/google.svg",
              height: 20,
            ),
            SizedBox(width: 10),
            Text(
              "Sign In with Google",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  RoundButton({
    @required this.onPressed,
    this.child,
    this.isSelected = false,
    this.color = const Color(0xFF202020),
    this.selectedColor = Colors.blueAccent,
  });

  final Widget child;
  final Function onPressed;
  final bool isSelected;
  final Color color;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: !isSelected ? 0 : 2.0,
      fillColor: !isSelected ? color : selectedColor,
      onPressed: onPressed,
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(width: 35.0, height: 35.0),
      child: child,
    );
  }
}

class OutlinedActionButton extends StatelessWidget {
  OutlinedActionButton({@required this.text, @required this.onPressed});

  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        onPressed();
      },
      borderSide: BorderSide(color: Colors.blueAccent),
      child: Container(
        width: 180,
        height: 45,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
