import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    return null;
  }
}
