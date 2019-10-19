import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage(this.user, this._location);
  final FirebaseUser user;
  final Address _location;
  static const routeName = '/hostAMeal';

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          width: 280,
          child: Text(
            "Currrently Hosted Orders",
            style: TextStyle(color: Colors.grey, fontSize: 30),
          ),
          margin: EdgeInsets.only(left: 10, top: 15),
        ),
        Container(
            child: new StreamBuilder(
                stream: Firestore.instance.collection('orders').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("No orders hosted currently.");
                  } else {
                    return ListView.builder(
                      itemCount: snapshot
                          .data.documents.length, //snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot ds = snapshot.data.documents[index];
                        Map combo = ds['items'];
                        String time = ds.data['scheduledtime'];
                        String dname = ds.documentID;

                        return Container(
                          //height: ds['items'].length.toDouble(),
                          //child: Card(child: Text('${ds['host']} \n ${combo['items'].length}')),
                          child: OneCard2(combo,time,dname),
                          //child: Text("${ds.documentID}"),
                        );
                      },
                    );
                  }
                }))
      ],
    );
  }
}

//This is one card or one combo
class OneCard2 extends StatefulWidget {
  OneCard2(this.combo, this.time, this.dname);
  final Map combo;
  final String time;
  final String dname;
  @override
  _OneCard2State createState() => _OneCard2State();
}

class _OneCard2State extends State<OneCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (50 * widget.combo['items'].length + 140).toDouble(),
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Color(0xffEAB543)),
      child: Column(
        children: <Widget>[
          Card(
              elevation: 0,
              color: Colors.transparent,
              child: Column(children: <Widget>[
                ListView.builder(
                  itemCount: widget.combo['items'].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        OneItem2(widget.combo, index),
                        //Text('${widget.combo.length}')
                      ],
                    );
                  },
                ),
              ]
                  //child: Text('${widget.combo['items'].length}'),
                  )),
           Container(
             child: Text('Scheduled at : ${widget.time}'),
             margin: EdgeInsets.only(top: 20),),
             FloatingActionButton(
               child: Text('Join'),
               heroTag: '${widget.dname}',
               onPressed: (){},
             )
        ],
      ),
    );
  }
}

class OneItem2 extends StatefulWidget {
  OneItem2(this.combo, this.index);
  final Map combo;
  final int index;
  //int count = combo.items.length;

  @override
  State<StatefulWidget> createState() => OneItem2State();
}

class OneItem2State extends State<OneItem2> {
  List<bool> Vals = new List();

  @override
  void initState() {
    super.initState();

    int count = widget.combo['items'].length;

    Vals = List<bool>.generate(count, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          child: Text(widget.combo['items'][widget.index]['item'].toString()),
          alignment: Alignment(-1, 0),
        ),
        Align(
            child:
                Text(widget.combo['items'][widget.index]['price'].toString()),
            alignment: Alignment(0.2, 0)),
        Align(
            child: Bool(widget.combo['items'][widget.index]['boolValue']),
            alignment: Alignment(0.6, 0))
      ],
    );
    //return Text("sda");
  }
}

Widget Bool(bool val) {
  if (val) {
    return Text("taken");
  } else {
    return Text("Available");
  }
}
