import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
 
      ),
      home: new LoginPage(new Auth()),
    );
  }
}

