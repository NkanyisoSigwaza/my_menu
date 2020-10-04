
import "package:flutter/material.dart";
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Models/Customer.dart';
import 'package:mymenu/Navigate/Wrapper.dart';
import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/States/UserDrawerState.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => _UserDrawerState();
}


class _UserDrawerState extends State<UserDrawer> {
  Customer customer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserDrawerState().customerInfo().then((value){
      customer = value;
      print(value.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDrawerState = Provider.of<UserDrawerState>(context);
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
                child: Text(
                    userDrawerState.name ?? "Nah"
                ),
              ),
              accountEmail: Text(
                  userDrawerState.email ?? "Nah"
              ),
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
