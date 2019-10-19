import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class MyUserInfo extends StatefulWidget{
  MyUserInfo(this.user);
  final FirebaseUser user;
  @override
  State<StatefulWidget> createState() => MyUserInfoState();
}

class MyUserInfoState extends State<MyUserInfo>{

  _showName() {
    if (widget.user.displayName == null) {
      String name = widget.user.email.split('@')[0];
      return name;
    } else {
      return widget.user.displayName;
    }
  }

  _showImage() {
    if (widget.user.photoUrl == null) {
      return AssetImage('assets/userIcon.png');
    } else {
      return NetworkImage(widget.user.photoUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Stack(
        children: <Widget>[
          //The container containing profile and name
          Container(
            color: Colors.yellow[700],
          ),

          Container(
            height: 250,
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(40))),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.1, 0.9),
                  child: Text(
                    _showName(),
                    style: TextStyle(fontSize: 24),
                  ),
                ),

                //),
              ],
            ),
          ),
          Align(
            alignment: Alignment(-1, -0.3),
            child: CircleAvatar(
              backgroundImage: _showImage(),
              backgroundColor: Colors.transparent,
              radius: 50,
            ),
          ),
        ],
      ),
    );
  }
}