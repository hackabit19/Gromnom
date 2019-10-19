import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'restaurant.dart';

class HomePage extends StatefulWidget {
  HomePage(this.user);
  final FirebaseUser user;
  static const routeName = '/hostAMeal';

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(
        context,
        Restaurant.routeName,
        arguments: UserArguments(widget.user),
      ),
      child: Text("Host an Order"),
    );
  }
}
