
import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Register.dart';
import 'package:mymenu/Authenticate/SignIn.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn; // changes state
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return Container(
        child:SignIn(toggleView: toggleView),
      );
    }
    else{
      return Container(
        child:Register(toggleView: toggleView),
      );
    }

  }
}
