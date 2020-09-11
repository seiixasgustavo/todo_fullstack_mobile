import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobile_fullstack/providers/auth.dart';
import 'package:todo_mobile_fullstack/providers/todos.dart';
import 'package:todo_mobile_fullstack/screens/login_page.dart';
import 'package:todo_mobile_fullstack/screens/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (context) => Auth()),
        ChangeNotifierProvider<Todos>(create: (context) => Todos()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: LoginPage(),
      ),
    );
  }
}
