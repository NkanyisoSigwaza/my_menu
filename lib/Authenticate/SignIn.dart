
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
      resizeToAvoidBottomInset: false,
      
      backgroundColor: Colors.black,

//      appBar: PreferredSize(
//        preferredSize: Size.fromHeight(80),
//        child: AppBar(
//          backgroundColor: Colors.grey[900],
//          elevation: 0,
//          title:Text(
//              "Sign in",
//            style:TextStyle(
//              color: Colors.white,
//              letterSpacing: 2,
//              fontSize: 25
//            ),
//          ),
//          centerTitle: true,
//          actions: <Widget>[
//            FlatButton.icon(
//              onPressed:(){
//                widget.toggleView();
//              },
//              icon:Icon(
//                Icons.person,
//              ),
//              label: Text(
//                  "Register",
//                style:TextStyle(
//                  letterSpacing: 1.2,
//                ),
//              ),
//            )
//          ],
//
//        ),
//      ),
      body: Container(
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image: AssetImage(
//                    "Picture/delDocLogo.png"
//                ),
//
//                fit: BoxFit.contain
//            )
//        ),
        padding:EdgeInsets.symmetric(vertical:20,horizontal: 50),
        child: Column(
          children: [



            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 10),
              child: Container(
               child:Image(
                 image:AssetImage(
                     "Picture/delDocLogo.png"
                 ),
               )
              ),
            ),
            Form(
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
                  FlatButton(
                    onPressed:() async{

                      singInState.signInClicked();

                    },
                    color:Colors.grey[900],
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
            RaisedButton(
              onPressed:() async{

                widget.toggleView();

              },
              color:Colors.black,
              child:Text(
                "Don't have an account? Register",
                style:TextStyle(
                  color:Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
