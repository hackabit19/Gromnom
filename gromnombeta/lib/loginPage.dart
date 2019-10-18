import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'buildApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.auth);
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

/*
 Creating a new enumeration.
 Add new piece of state to tell if: 
 • The user is logging in or,
 • Creating a new account.
 */

enum FormType { login, register }

/*Underscores (_) are used to modify access to "private" 
i.e. not accessible from different files*/

enum AuthStatus { notSignedIn, signedIn }

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  FirebaseUser user;
  AuthStatus authStatus = AuthStatus.notSignedIn;
  String userString;
  var userId;

  @override
  void initState() {
    super.initState();
    //This method checks  the status of the user when we initially start the app
    widget.auth.currentUser().then((userId)
        //This is same as -
        // userId = await widget.auth.currentUser()
        {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  Future<String> getUserDataString() async {
    userString = await user.toString();
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
      print("login should work");
    });

    Firestore.instance
        .collection("users")
        .where('uid', isEqualTo: user.uid)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        print("Old user");
        print('${user.uid}');
        print('${docs.documents[0].data}');
      } else {
        print("New User");
        Firestore.instance.collection('users').add({'email': user.email, 'uid': user.uid, 'membersince': DateTime.now()});
      }
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(_email);
      print(_password);
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      //try{
      if (_formType == FormType.login) {
        print("login");
        FirebaseUser newUser =
            await widget.auth.signInWithEmailAndPassword(_email, _password);
        newUser == null
            ? print("Incorrect username or password")
            : setState(() {
                user = newUser;
              });
        _signedIn();
        //userId = null if username and password were incorrect

        print('Signed in: $user');
      } else if (_formType == FormType.register) {
        print("register");
        FirebaseUser newUser =
            await widget.auth.createUserWithEmailAndPassword(_email, _password);
        setState(() {
          user = newUser;
        });
        print('Registered user: $user');
      }
    }
  }

  Future<String> awaitLogin() async {
    await AuthStatus.signedIn;
  }

  Future<String> loginWithGoogle() async {
    user = await widget.auth.signInWithGoogle();
    if (user != null) _signedIn();

    print('Registered user: $user');
  }

  void moveToRegister() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      print("routing to home");
    });
  }

  void moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  List<Widget> title() {
    return [
      new SizedBox(
        height: 140,
      ),
      new SizedBox(
        height: 20,
      ),
      new Center(
        child: Hero(
          child: Text(
            "GROMNOM",
            style: TextStyle(),
          ),
          tag: 'title',
        ),
      ),
      new SizedBox(
        height: 40,
      ),
    ];
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: InputDecoration(labelText: 'email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
          decoration: InputDecoration(labelText: 'password'),
          obscureText: true, //for hiding passwords
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value),
      new SizedBox(
        height: 20,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        Material(
          borderRadius: BorderRadius.circular(25),
          color: Colors.yellow[600],
          child: new MaterialButton(
            child: new Text('Login'),
            elevation: 6,
            onPressed: validateAndSubmit, //calls a function validateAndSave
          ),
        ),
        new SizedBox(
          height: 10,
        ),
        Material(
          color: Colors.yellow[600],
          borderRadius: BorderRadius.circular(25),
          child: new MaterialButton(
            child: new Text('Create an Account'),
            onPressed: moveToRegister,
            elevation: 6,
          ),
        ),
        new SizedBox(
          height: 10,
        ),
        Material(
          color: Colors.yellow[600],
          borderRadius: BorderRadius.circular(25),
          child: new MaterialButton(
            child: new Text('Login with Google'),
            onPressed: loginWithGoogle,
            elevation: 6,
          ),
        )
      ];
    } else if (_formType == FormType.register) {
      return [
        new RaisedButton(
          child: new Text('Create an account'),
          onPressed: validateAndSubmit, //calls a function validateAndSave
        ),
        new FlatButton(
          child: new Text('Already have an account? Login'),
          onPressed: moveToLogin,
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    /**Everything is inside this Scaffold() 
     * which is returned when we build(BulidContext context) this widget.**/
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: new Container(
                color: Colors.white,
                /**So that they dont go to the end and have a padding around them
             * Applies to all the children of this particular container.
             */

                padding: EdgeInsets.all(16),
                child: new Form(
                  /**
               * Declaring this formKey will store the value for the form
               * for validation.
              */
                  key: _formKey,
                  child: new Column(
                    /**To change the position and alignment of the login bar */
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: title() + buildInputs() + buildSubmitButtons(),
                  ),
                )),
          ),
        );
      case AuthStatus.signedIn:
        return new FutureBuilder<String>(
          future: awaitLogin(), // a Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return null;
              // case ConnectionState.waiting:
              //   return Scaffold(
              //     body: Center(child: new Text('Loading...')),
              //     backgroundColor: Colors.white,
              //   );
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return BuildApp(widget.auth, _signedOut, user);
            }
          },
        );
    }
  }
}
