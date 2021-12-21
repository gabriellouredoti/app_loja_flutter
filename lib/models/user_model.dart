
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  void signUp({required Map<String, dynamic> userData, required String pass, required VoidCallback onSuccess, required VoidCallback onFail}){
    
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: userData["email"],
      password: pass
    )
    .then((user) async {
     
      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    })
    .catchError((err){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  void signIn() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();

  }

  void recoveryPass(){   
    
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    notifyListeners();

  }

  bool isLoggedIn(){
    return _auth.currentUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser?.uid).set(userData);
    
  }

}