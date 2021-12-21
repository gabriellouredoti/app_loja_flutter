
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  // Mostra o usuaário quando o app abre
  @override
  void addListener(VoidCallback listener) async {
    // TODO: implement addListener
    super.addListener(listener);

    await _loadCurrentUser();
  }

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

  void signIn({required String email, required String password, 
    required VoidCallback onSuccess, required VoidCallback onFail}) async {
    
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: password)
      .then((user) async {

        await _loadCurrentUser();

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

  Future<Null> _loadCurrentUser() async {
    if(_auth.currentUser != null){

      if(userData["name"] == null){

        DocumentSnapshot docUser = await FirebaseFirestore.instance.collection("users")
          .doc(_auth.currentUser?.uid).get();

        userData = docUser.data() as Map<String, dynamic>;
      }
      
    }

    notifyListeners();
  }
 
}