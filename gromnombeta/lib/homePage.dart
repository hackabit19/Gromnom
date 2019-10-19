import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget{
  HomePage(this.user);
  final FirebaseUser user;
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Text("HomePage");
  }
  
}