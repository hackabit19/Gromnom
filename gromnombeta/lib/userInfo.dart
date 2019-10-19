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

  // _memberSince(){
  //  var doc = Firestore.instance.collection('users').document('${widget.user.email}').get();
  //  print(doc.membersince);
  // }

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
            height: 1080,
            color: Color(0xffecf0f1),
          ),

          Container(
            height: 250,
            decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius:
                    BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50)),
                boxShadow: [
                    new BoxShadow(
                      color: Color(0xff7f8c8d),
                      offset: new Offset(0.0, 1.0),
                      blurRadius: 50.0,
                      spreadRadius: 5.0
                  )]
                ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.5),
                  child: Text(
                    _showName().toString(),
                    style: TextStyle(
                            color: Color(0xff2c3e50),
                            fontSize: 30,
                            fontFamily: 'SFDisplay',
                            fontWeight: FontWeight.w500,
                    )
                  ),
                ),

                //),
              ],
            ),
          ),
          Align(
            alignment: Alignment(0.0, -0.8),
            child: CircleAvatar(
              backgroundImage: _showImage(),
              backgroundColor: Colors.transparent,
              radius: 50,
            ),
          ),
          // Align(alignment: Alignment(0, 0),
          // child: Container(
          //   child: _memberSince(),
          // ),)
        ],
      ),
    );
  }
}