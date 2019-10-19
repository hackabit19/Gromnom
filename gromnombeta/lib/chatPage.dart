import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this.user, this.chatid) : super();
  final FirebaseUser user;
  final String chatid;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;

  var orderCount = 0;

  //A list of type Msg -> Stateless Widgets that hold all the text that the user inputs
  final List<Msg> _messages = <Msg>[];
  //This allows us to control what's happening with our input box
  final TextEditingController _textController = new TextEditingController();
  ScrollController scrollController = ScrollController();
  bool _isWriting = false;

  Future<void> callback() async {
    if (_textController.text.length > 0) {
      await _fireStore
          .collection('messages')
          .add({'text': _textController.text, 'from': widget.user.displayName});
    }
  }

  @override
  Widget build(BuildContext context) {
    // if(orderCount == 0)
    // {
    //   return Text("You have no open chats");
    // }
    // else{
    //   return Card();
    // }

    return Scaffold(
      appBar: AppBar(
        leading: FloatingActionButton(
            backgroundColor: Color(0xffEAB543),
            elevation: 0,
            child: Icon(Icons.arrow_back, color: Color(0xfff5f5f5)),
            heroTag: "go back",
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Color(0xffEAB543),
        title: Text(
          "",
          style: TextStyle(
            color: Color(0xfff5f5f5),
            fontSize: 22,
            fontFamily: 'SFDisplay',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            new Flexible(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('chatgroups')
                        .document('${widget.chatid}')
                        .snapshots(),
                    builder: (context, index) {
                      return Container(
                        child: Text('${Firestore.instance.collection('chatgroups').document('${widget.chatid}')}'),
                      );
                    }
                    // new ListView.builder(
                    //   itemBuilder: (context, index) =>
                    //       _messages[index], //Each msg is a different object
                    //   itemCount: _messages.length,
                    //   reverse:
                    //       true, //this means start at the bottom and move to the top
                    //   padding: EdgeInsets.all(6.0),
                    // ),
                    )),
            new Divider(height: 1.0),
            new Container(
                child: _buildComposer(), //this is the input field
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return
        // new IconTheme(
        //   data: new IconThemeData(color: Colors.white),

        //child:
        new Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),

      margin: EdgeInsets.symmetric(horizontal: 9.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            //Input Field
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(left: 10, top: 15, bottom: 10),
              child: new TextField(
                controller: _textController,
                onChanged: (String txt) {
                  setState(() {
                    _isWriting = (txt.length > 0);
                  });
                },
                decoration: new InputDecoration.collapsed(
                    hintText: "Write a message..."),
              ),
            ),
          ),
          new Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              margin: EdgeInsets.symmetric(horizontal: 3.0),
              child: new IconButton(
                //Send Button
                icon: Icon(Icons.send),
                onPressed:
                    _isWriting ? () => _submitMsg(_textController.text) : null,
              ))
        ],
      ),
      //  ),
    );
  }

  _submitMsg(String txt) {
    //Cleans the textField and changes state
    _textController.clear();
    setState(() {
      _isWriting = false;
    });

    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 300)),
    );

    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

class Msg extends StatelessWidget {
  Msg({Key key, this.txt, this.from, this.me, this.animationController});
  final String txt;
  final String from;
  final bool me;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return SizeTransition(
      sizeFactor: new CurvedAnimation(
        parent: animationController,
        curve:
            Curves.easeOut, //this decides what type of animation is being used
      ),
      axisAlignment: 0.0,
      child: new Container(
        padding: EdgeInsets.all(8),
        //  color: Colors.yellow,
        //padding: EdgeInsets.only(top:8,bottom: 8,left: 8,),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10, top: 3),
              child: CircleAvatar(child: Text(defaultUserName[0])),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 5, left: 12, bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, //alignment of all the text
                  children: <Widget>[
                    Text(
                      defaultUserName,
                      style: Theme.of(ctx).textTheme.subhead,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.only(right: 10.0, top: 6.0),
                      child: new Text(txt),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var defaultUserName = "Benedict Cumberbatch";
}

class Message extends StatelessWidget {
  String from;
  String text;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
