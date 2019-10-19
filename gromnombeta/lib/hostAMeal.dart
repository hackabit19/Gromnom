import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromnombeta/podoRest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'podoMeal.dart';

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

  Future _getCombos() async {
    var url = "http://192.168.0.102/data.JSON";
    var response = await http.get(url);

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          jsonResponse = json.decode((response.body));
        });
      }
    }
    Combos combos = Combos.fromJson(jsonResponse);
    return combos;
  }

  @override
  Widget build(BuildContext context) {
    final RestArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEAB543),
        title: Text(
          '${args.restaurantInfo.name}',
          style: TextStyle(
            color: Color(0xfff5f5f5),
            fontSize: 22,
            fontFamily: 'SFDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getCombos(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.combo.length,
            itemBuilder: (context, index) {
              Combo combo = snapshot.data.combo[index];

              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  OneCard(combo, args.user),
                  Divider(
                    color: Colors.orange,
                    height: 5,
                    indent: 35,
                    endIndent: 35,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class OneCard extends StatefulWidget {
  OneCard(this.combo, this.user);
  final Combo combo;
  final FirebaseUser user;
  @override
  _OneCardState createState() => _OneCardState();
}

class _OneCardState extends State<OneCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (50 * widget.combo.items.length + 10).toDouble(),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Color(0xffEAB543)),
      child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.combo.items.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      OneItem(widget.combo, index),
                    ],
                  ),
                );
              },
            ),
          ])),
    );
  }
}

class OneItem extends StatefulWidget {
  OneItem(this.combo, this.index);
  final Combo combo;
  final int index;
  //int count = combo.items.length;

  @override
  State<StatefulWidget> createState() => OneItemState();
}

//This class returns one item or one row of the class
class OneItemState extends State<OneItem> {
  List<bool> Vals = new List();

  @override
  void initState() {
    super.initState();

    int count = widget.combo.items.length;

    Vals = List<bool>.generate(count, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Align(
          child: Text(widget.combo.items[widget.index].item.toString()),
          alignment: Alignment(-1, 0),
        ),
        Align(
            child: Text(widget.combo.items[widget.index].price.toString()),
            alignment: Alignment(0.3, 0)),
      ],
    );
  }
}
