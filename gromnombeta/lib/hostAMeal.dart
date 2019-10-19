import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromnombeta/podoRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class RestArguments {
  final FirebaseUser user;
  final RestaurantInfo restaurantInfo;
  RestArguments(this.user, this.restaurantInfo);
}

class HostAMeal extends StatefulWidget {
  static const routeName = '/hostAMeal';

  @override
  State<StatefulWidget> createState() => HostAMealState();
}

class HostAMealState extends State<HostAMeal> {

  var jsonResponse;

  Future _getCombos() async{
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
    final RestArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEAB543),
        title: Text(
          "Pick a Meal",
          style: TextStyle(
            color: Color(0xfff5f5f5),
            fontSize: 22,
            fontFamily: 'SFDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // body: FutureBuilder(
      //   future: _getCombos(),
      //   builder: (context, AsyncSnapshot snapshot){

      //   },
      // ),
      
    );
  }
}
