import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserArguments {
  final FirebaseUser user;
  UserArguments(this.user);
}

class Restaurant extends StatefulWidget {
  static const routeName = '/hostAMeal';

  @override
  State<StatefulWidget> createState() => RestaurantState();
}

class RestaurantState extends State<Restaurant> {
  @override
  Widget build(BuildContext context) {
    final UserArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEAB543),
        title: Text(
          "Pick a Restaurant",
          style: TextStyle(
            color: Color(0xfff5f5f5),
            fontSize: 22,
            fontFamily: 'SFDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
