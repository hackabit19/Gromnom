import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gromnombeta/chatPage.dart';

class ChatIndex extends StatefulWidget {
  ChatIndex(this.user);
  final FirebaseUser user;
  @override
  State<StatefulWidget> createState() => ChatIndexState();
}

class ChatIndexState extends State<ChatIndex> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: Firestore.instance.collection('chatgroups').snapshots(),
            builder: (context, snapshot) {
              int count = 0;
              List<int> indices = [];

              for (var i = 0; i < snapshot.data.documents.length; i++) {
                if (snapshot.data.documents[i]['users']
                    .toString()
                    .contains(widget.user.email.toString())) {
                  count++;
                  indices.add(i);
                }
              }

              if (count == 0) {
                return Text('You have no open orders');
              }

              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                    widget.user,
                                    snapshot.data.documents[indices[index]]
                                        ['orderid'])));
                      },
                      child: Container(
                          color: Colors.yellow,
                          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                          padding: EdgeInsets.only(
                              top: 25, bottom: 25, left: 15, right: 15),
                          child: Text(snapshot.data.documents[indices[index]]
                              ['orderid'])),
                    );
                  });
            })
        //Text('${snapshot.data.documents[0]['users']}');

        );
  }
}
