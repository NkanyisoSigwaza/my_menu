import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Shared/Constants.dart';
import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/States/RegisterState.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  Widget build(BuildContext context) {
   final registerState = Provider.of<RegisterState>(context);
    return registerState.loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                backgroundColor: Colors.grey[400],
                elevation: 0,
                title: Text(
                  "Sign up",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                    ),
                    label: Text(
                      "Sign in",
                      style: TextStyle(letterSpacing: 1.2),
                    ),
                  )
                ],
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: registerState.formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Email"),

                      validator: (val){
                       return registerState.validateEmail(val);
                      },
                      onChanged: (val) {
                        //returns a value each time the user types or deletes something
                        setState(() {
                          registerState.email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
                      validator: (val) {
                       return registerState.validatePassword(val);
                      },
                      obscureText: true, // encrypts password
                      onChanged: (val) {
                        //returns a value each time the user types or deletes something
                        setState(() {
                          registerState.password = val;
                        });
                      },
                    ),
                    SizedBox(height: 50),
                    RaisedButton(
                      onPressed: () async {

                        registerState.registerClicked();
                      },
                      color: Colors.black,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      registerState.error,
                      style: TextStyle(
                        color: Colors.red,
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
