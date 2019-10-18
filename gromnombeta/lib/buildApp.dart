import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BuildApp extends StatefulWidget {
  BuildApp(this.auth, this.onSignedOut, this.user) : super();
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  FirebaseUser user;

  @override
  _BuildAppState createState() =>
      _BuildAppState();
}

class _BuildAppState extends State<BuildApp> {
  

  void _signOut() async {
    try {
      await widget.auth.signOut();
      widget.user = null;
      widget.onSignedOut();
    } catch (e) {
      print('Error: $e');
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Hero(tag: 'title', child: Text("Gromnom")),
        actions: <Widget>[
          FloatingActionButton(
            elevation: 0,
            child: Icon(Icons.arrow_back),
            heroTag: "logout",
            onPressed: () => _signOut(),
          )
        ],
      ),
      body: Text("Home page")
          
      
    );
  }
}
