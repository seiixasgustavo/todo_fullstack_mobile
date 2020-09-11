import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoginInput extends StatelessWidget {
  LoginInput({this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        child: child,
      ),
    );
  }
}

class DateTimeInput extends StatelessWidget {
  DateTimeInput({@required this.onPress, @required this.date});

  final Function onPress;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        DateFormat("MMMM dd hh:mm a").format(date),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
