import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? _nick;

  String? get nick => _nick;
  bool get isAuthenticated => _auth.currentUser != null;

  Future<void> register(String nick, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _nick = nick;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
      throw e; 
      
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _nick = null;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
