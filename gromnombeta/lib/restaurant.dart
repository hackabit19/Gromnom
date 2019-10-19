import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:gromnombeta/hostAMeal.dart';
import 'package:gromnombeta/podoRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserArguments {
  final FirebaseUser user;
  final Address location;
  UserArguments(this.user, this.location);
}

class Restaurant extends StatefulWidget {
  static const routeName = '/restaurant';

  @override
  State<StatefulWidget> createState() => RestaurantState();
}

class RestaurantState extends State<Restaurant> {
  var jsonResponse;

  Future _getRestaurants() async {
    var url =
        "http://192.168.43.47:8080/fetchrestaurants/?pincode=835215&address=%20Mesra";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          jsonResponse = json.decode((response.body));
        });
      }
    }

    Restaurants restaurants = Restaurants.fromJson(jsonResponse);
    return restaurants;
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
      body: FutureBuilder(
        future: _getRestaurants(),
        builder: (context, AsyncSnapshot snapshot) {
          //return Text('${snapshot.data.restaurants[0]}');
          if (!snapshot.hasData) return Center(child: Text("Connecting"));

          return ListView.builder(
            itemCount: snapshot.data.restaurants.length,
            itemBuilder: (context, index) {
              //Combo combo = snapshot.data.combo[index];
              RestaurantInfo restaurant =
                  snapshot.data.restaurants[index]; //.restaurants[index];
              if (!snapshot.hasData) return Center(child: Text("Connecting"));

              return Container(child: OneRest(args.user, restaurant));
            },
          );
        },
      ),
    );
  }
}

class OneRest extends StatefulWidget {
  OneRest(this.user, this.restaurantInfo);
  final FirebaseUser user;
  final RestaurantInfo restaurantInfo;
  @override
  State<StatefulWidget> createState() => OneRestState();
}

class OneRestState extends State<OneRest> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, HostAMeal.routeName,
            arguments: RestArguments(widget.user, widget.restaurantInfo));
      },
      child: Container(
        height: 80,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Color(0xffEAB543),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            Text('${widget.restaurantInfo.name}'),
            Text('Rating : ${widget.restaurantInfo.rating}'),
            Text('Cost for two : ${widget.restaurantInfo.costfortwo}')
            //SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
