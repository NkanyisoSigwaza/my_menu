
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Shared/Constants.dart';
import 'package:mymenu/Shared/Loading.dart';

class SignIn extends StatefulWidget {


  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>(); // will allow us to validate our form make sure the user doesnt f up
  final Auth _auth = Auth();
  String error = "";
  // text field state
  String email = "";
  String  password ="";

  @override
  Widget build(BuildContext context) {
    //if loading is true  return loading widget
    return loading? Loading() :Scaffold(
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
          key:_formKey,
          child:Column(
            children: <Widget>[
              SizedBox(
                height:20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email") ,
                validator: (val){
                  if(val.isEmpty){
                    //user didn't enter email
                    return "Enter email";
                  }
                  else{
                    //user entered email
                    // could have done validator: (val) => val.isEmpty? "Enter an email":null;
                    return null;
                  }
                },
                onChanged: (val){
                  //returns a value each time the user types or deletes something
                  setState(() {
                    email = val;
                  });
                },

              ),
              SizedBox(
                  height:20
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val) {
                  if (val.length < 6) {
                    //user didn't enter valid password
                    return "Enter password 6 characters long";
                  }
                  else {
                    //user entered valid password

                    return null;
                  }
                },
                obscureText: true,// encrypts password
                onChanged: (val){
                  //returns a value each time the user types or deletes something
                  setState(() {
                    password = val;
                  });
                },

              ),
              SizedBox(
                  height:50
              ),
              RaisedButton(
                onPressed:() async{

                  if(_formKey.currentState.validate()){
                    // after validating if entered correct entries
                    setState(() {
                      loading = true;
                    });
                    //true/ false if email and correct type password entered
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);//used dynamic because could either get user or null

                    if(result==null){
                      setState(() {
                        error = "Could not sign in with those credentials";
                        loading = false;
                        print(error);
                      });
                    }
                    print(email);
                    print(password);
                  }
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
                error,
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
