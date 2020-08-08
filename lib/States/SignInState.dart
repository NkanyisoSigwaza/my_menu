import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Models/User.dart';

class SignInState with ChangeNotifier {

  bool loading = false;
  final _formKey = GlobalKey<
      FormState>(); // will allow us to validate our form make sure the user doesnt f up
  final FirebaseAuth _auth= FirebaseAuth.instance;
  String error = "";

  // text field state
  String email = "";
  String password = "";

  //GETTERS
  GlobalKey<FormState> get formKey => _formKey;


  SignInState();

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



  signInClicked() async {
    if (_formKey.currentState.validate()) {
      // after validating if entered correct entries
      //true:false if email and correct type password entered
      loading = true;


      dynamic result = await signInWithEmailAndPassword(
          email, password); //used dynamic because could either get user or null

      if (result == null) {
        error = "Could not sign in with those credentials";
        loading = false;

      }

    }

    notifyListeners();
  }

  // Returns user object which contains firebaseID
  User _userFromFireBaseUser(FirebaseUser user){
    return user!=null ? User(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result  = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser fb_user = result.user;
      return _userFromFireBaseUser(fb_user);
    }
    catch(e){
      print(e);
      print("could not sign in");
      return null;

    }
  }




}