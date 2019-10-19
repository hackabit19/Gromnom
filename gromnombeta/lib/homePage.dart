import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'restaurant.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  HomePage(this.user);
  final FirebaseUser user;
  static const routeName = '/hostAMeal';

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Address> address;
  var location = new Location();
  LocationData locationData;
  Address _location;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    try {
      locationData = await location.getLocation();
      Coordinates coordinates =
          new Coordinates(locationData.latitude, locationData.longitude);

      address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      _location = address.first;

      print(
          "${_location.featureName} : ${_location.coordinates} : ${_location.locality} : ${_location.postalCode}");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
          children: <Widget>[
        FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            Restaurant.routeName,
            arguments: UserArguments(widget.user,_location),
          ),
          child: Text("Host an Order"),
        ),
      ],
    );
  }
}
