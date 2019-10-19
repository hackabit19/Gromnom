import 'package:flutter/material.dart';
import 'package:gromnombeta/homePage.dart';
import 'package:gromnombeta/restaurant.dart';
import 'loginPage.dart';
import 'auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SFDisplay',
        ),
        routes: {
        //'/chatPage': (context) => ChatPage(),
        Restaurant.routeName: (context) => Restaurant(),
      },
      home: new LoginPage(new Auth()),
    );
  }
}

