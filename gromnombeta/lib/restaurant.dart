import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



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

  var jsonResponse;

  Future _getRestaurants() async{
    var url = "";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          jsonResponse = json.decode((response.body));
        });
      }
    }

  }

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
      // body: FutureBuilder(
      //   future: _getRestaurants(),
      //   builder: (context, AsyncSnapshot snapshot){

      //   },
      // ),
      
    );
  }
}
