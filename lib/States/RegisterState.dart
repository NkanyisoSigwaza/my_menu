import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Auth.dart';

class RegisterState with ChangeNotifier{

  bool loading = false;
  final _formKey = GlobalKey<FormState>(); // will allow us to validate our form make sure the user doesnt f up
  String error = "";
  final Auth _auth = Auth();  //will change later
  String email = "";
  String password="";
  final FirebaseAuth _firebase_auth = FirebaseAuth.instance;


  GlobalKey<FormState> get formKey => _formKey;

  Auth get auth => _auth;
  notifyListeners();

  RegisterState(){

  }

  // Ensures that user types in correct email
  String validateEmail(String value){
    if(value.isEmpty){
      //user didn't enter email
      notifyListeners();
      return "Enter email";
    }
    //user entered email correctly
    notifyListeners();
    return null;


  }





}