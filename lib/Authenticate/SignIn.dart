
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Shared/Constants.dart';
import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/States/SignInState.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {


  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  Widget build(BuildContext context) {

    final singInState = Provider.of<SignInState>(context);

    //if loading is true  return loading widget
    return singInState.loading? Loading() :Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.grey[400],
          elevation: 0,
          title:Text(
              "Sign in",
            style:TextStyle(
              color: Colors.black,
              letterSpacing: 2,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              onPressed:(){
                widget.toggleView();
              },
              icon:Icon(
                Icons.person,
              ),
              label: Text(
                  "Register",
                style:TextStyle(
                  letterSpacing: 1.2,
                ),
              ),
            )
          ],

        ),
      ),
      body: Container(
        padding:EdgeInsets.symmetric(vertical:20,horizontal: 50),
        child: Form(
          key:singInState.formKey,
          child:Column(
            children: <Widget>[
              SizedBox(
                height:20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email") ,
                validator: (val){
                 return singInState.validateEmail(val);
                },
                onChanged: (val){
                  //returns a value each time the user types or deletes something
                  setState(() {
                    singInState.email = val;
                  });
                },

              ),
              SizedBox(
                  height:20
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val) {
                  return singInState.validatePassword(val);
                },
                obscureText: true,// encrypts password
                onChanged: (val){
                  //returns a value each time the user types or deletes something
                  setState(() {
                    singInState.password = val;
                  });
                },

              ),
              SizedBox(
                  height:50
              ),
              RaisedButton(
                onPressed:() async{

                  singInState.signInClicked();

                },
                color:Colors.black,
                child:Text(
                  "Sign in",
                  style:TextStyle(
                    color:Colors.white,
                  ),
                ),
              ),
              Text(
                singInState.error,
                style:TextStyle(
                  color:Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
