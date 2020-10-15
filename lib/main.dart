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
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(ctx);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              LoginPage.routeName: (ctx) => LoginPage(),
              MainPage.routeName: (ctx) => MainPage(),
            },
            theme: ThemeData.dark(),
            home: auth.isAuth ? MainPage() : LoginPage(),
          ),
        ),
      ),
    );
  }
}
