import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';


abstract class BaseAuth{
    Future<FirebaseUser> signInWithEmailAndPassword(String email, String password); 
    Future<FirebaseUser> createUserWithEmailAndPassword(String email, String password); 
    Future<String> currentUser();
    Future<void> signOut();
}

class Auth implements BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {    
    try{
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user;
    }
    catch(PlatformException){print("Wrong Email Format");}
    
  }

  Future<FirebaseUser> createUserWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user;
  }

  Future<String> currentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    try{return user.uid;}
    catch(e) {print('Error: $e');}
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}