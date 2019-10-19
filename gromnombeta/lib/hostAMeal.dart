import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromnombeta/hostAMealPreview.dart';
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
    var url = "http://192.168.0.103:8080/combos/?city=ranchi&code=101019";
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
              if (!snapshot.hasData) return Center(child: Text("Connecting"));

              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  OneCard(combo, args.user, args.restaurantInfo),
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
  OneCard(this.combo, this.user, this.restaurantInfo);
  final Combo combo;
  final FirebaseUser user;
  final RestaurantInfo restaurantInfo;

  @override
  _OneCardState createState() => _OneCardState();
}

class _OneCardState extends State<OneCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (50 * widget.combo.items.length + 25).toDouble(),
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
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      HostAMealPreview.routeName,
                      arguments: MealArguments2(widget.combo, widget.user, widget.restaurantInfo),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      OneItem(widget.combo, index, widget.restaurantInfo),
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
  OneItem(this.combo, this.index, this.restaurantInfo);
  final Combo combo;
  final int index;
  final RestaurantInfo restaurantInfo;

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
          child: Text(
            widget.combo.items[widget.index].item.toString(),
            style: TextStyle(
              color: Color(0xfff5f5f5),
              fontSize: 18,
              fontFamily: 'SFDisplay',
              fontWeight: FontWeight.w400,
            ),
          ),
          alignment: Alignment(-1, 0),
        ),
        Align(
            child: Text(widget.combo.items[widget.index].price.toString(),
                style: TextStyle(
                  color: Color(0xfff5f5f5),
                  fontSize: 18,
                  fontFamily: 'SFDisplay',
                  fontWeight: FontWeight.w400,
                )),
            alignment: Alignment(0.3, 0)),
      ],
    );
  }
}
