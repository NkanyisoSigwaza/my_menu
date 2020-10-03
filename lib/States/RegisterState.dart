import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Models/User.dart';

class RegisterState with ChangeNotifier {
  bool loading = false;
  final _formKey = GlobalKey<
      FormState>(); // will allow us to validate our form make sure the user doesnt f up
  String error = "";
  //Auth _auth; //will change later
  String email = "";
  String password = "";
  final FirebaseAuth _auth= FirebaseAuth.instance;
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController passwordOriginal = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController emailValue = TextEditingController();


  //GETTERS
  GlobalKey<FormState> get formKey => _formKey;

  //Auth get auth => _auth;

  RegisterState() {

  }

  // Ensures that user types in correct email
  String validateEmail(String email) {
    if (email.isEmpty) {
      //user didn't enter email

      notifyListeners();
      return "Enter email";
    }
    //user entered email correctly
    notifyListeners();
    return null;
  }

  String validateName(String name) {
    if (name.isEmpty) {
      //user didn't enter email

      notifyListeners();
      return "Enter Name";
    }
    //user entered email correctly
    notifyListeners();
    return null;
  }

  String validateSurname(String surname) {
    if (surname.isEmpty) {
      //user didn't enter email

      notifyListeners();
      return "Enter Surname";
    }
    //user entered email correctly
    notifyListeners();
    return null;
  }

  // ensures user types correct password
  String validatePassword(String password) {
    if (password.length < 6) {
      //user didn't enter valid password

      notifyListeners();
      return "Enter password 6 characters long";
    }
    notifyListeners();
    //user entered valid password
    return null;
  }

  // ensures user types correct password
  String confirmPassword(String password) {
    if (password != passwordOriginal.text) {
      //user didn't enter valid password

      notifyListeners();
      return "Passwords do not match!";
    }
    notifyListeners();
    //user entered valid password
    return null;
  }

  // once register button is clicked

  registerClicked() async {
    if (_formKey.currentState.validate()) {
      // if the form is valid

      loading = true;

      dynamic result = await registerWithEmailAndPassword(
          email, password); //used dynamic because could either get user or null
      if (result == null) {
        loading = false;
        error = "please supply a valid email";
      }
      else{

      }
    }
    notifyListeners();
  }

  // Returns user object which contains firebaseID
  User _userFromFireBaseUser(FirebaseUser user){
    return user!=null ? User(userId: user.uid) : null;
  }

  // registers new user
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //grab user from that result
      FirebaseUser fb_user  = result.user;

      //create a new document for user with uid
      return _userFromFireBaseUser(fb_user);
      // will only work if it was succesful ie can sign in with email and password
    }
    catch(e){
      print(e);
      print("could not create user");
      return null;

    }
  }

}
