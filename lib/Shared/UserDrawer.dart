
import "package:flutter/material.dart";
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Navigate/Wrapper.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right:80),
      color:Colors.grey[800],
      child: ListView(
        children: <Widget>[
          Container(


            height:300,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),


              accountName: Padding(
                padding: const EdgeInsets.only(bottom:12),
                child: Text("Nkanyiso"),
              ),
              accountEmail: Text("sgwnka001@myuct.ac.za"),
              currentAccountPicture:CircleAvatar(
                radius:50,
                backgroundImage:AssetImage("Picture/avatar.png") ,
                backgroundColor: Colors.grey[400],


              ),
            ),
          ),

          ListTile(
            title:Text(
                "Sign out",
              style: TextStyle(
                color:Colors.red
              ),
            ),
            onTap: (){
              Auth().signOut();
              Navigator.of(context).pop();//closes menu in home pAGE
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Wrapper())
              );
            },
          ),
          Divider(
            height:5,
            color:Colors.black,
          ),
        ],
      ),
    );
  }
}
