import 'package:flutter/material.dart';


class BuildApp extends StatefulWidget {

  @override
  _BuildAppState createState() =>
      _BuildAppState();
}

class _BuildAppState extends State<BuildApp> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Hero(tag: 'title', child: Text("Gromnom")),
      ),
      body: Text("Home page")
          
      
    );
  }
}
