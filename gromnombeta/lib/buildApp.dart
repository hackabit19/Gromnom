import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gromnombeta/homePage.dart';
import 'package:gromnombeta/userInfo.dart';
import 'auth.dart';
import 'userInfo.dart';

class BuildApp extends StatefulWidget {
  BuildApp(this.auth, this.onSignedOut, this.user) : super();
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  FirebaseUser user;

  @override
  _BuildAppState createState() =>
      _BuildAppState(this.auth, this.onSignedOut, this.user);
}

class _BuildAppState extends State<BuildApp> {
  _BuildAppState(this.auth, this.onSignedOut, this.user) : super();

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  static BaseAuth passAuth;
  FirebaseUser user;

  void _signOut() async {
    try {
      await auth.signOut();
      user = null;
      onSignedOut();
    } catch (e) {
      print('Error: $e');
    }
  }

  int currentTab = 0;
  PageController _myPage;

  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: currentTab);
    passAuth = widget.auth;
  }

//Function for onTap value of BottomBar.
//Scaffold body is rendered again with new currentTab value
  void onItemTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      currentTab = index;
      //The following line does both the navigation & animation
      _myPage.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEAB543),
        title: Text(
          "Gromnom",
          style: TextStyle(
                            color: Color(0xfff5f5f5),
                            fontSize: 22,
                            fontFamily: 'SFDisplay',
                            fontWeight: FontWeight.w500,
                          ),
              ),
        actions: <Widget>[
          FloatingActionButton(
            backgroundColor: Color(0xffEAB543),
            elevation: 0,
            child: Icon(Icons.power_settings_new, color: Color(0xfff5f5f5)),
            heroTag: "logout",
            onPressed: () => _signOut(),
          )
        ],
      ),
      body: PageView(
        controller: _myPage,
        //So that when we swipe pages, BottomBar gets updated
        onPageChanged: (index) => onItemTapped(index),
        children: <Widget>[HomePage(user), MyUserInfo(user)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.shifting,
        backgroundColor: Color(0xffEAB543),
        fixedColor: Color(0xfff5f5f5),
        currentIndex: currentTab,
        onTap: (int index) {
          bottomTapped(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('User')),
        ],
      ),
    );
  }
}
