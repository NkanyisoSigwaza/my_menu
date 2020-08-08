
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Authenticate/Authenticate.dart';
import 'package:mymenu/Authenticate/SignIn.dart';

import 'package:mymenu/Home/CheckOut.dart';
import 'package:mymenu/Maps/MyMap.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Navigate/Wrapper.dart';

import 'package:mymenu/Shared/Database.dart';

import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/Home/MyListView.dart';
import 'package:mymenu/States/HomeState.dart';

import 'package:provider/provider.dart';

import 'package:mymenu/VoucherHome/VoucherHome.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    final foodAndConnect = Provider.of<List<FoodItem>>(context);
    final homeState = Provider.of<HomeState>(context);



    return  foodAndConnect==null ? Loading():Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MyAppBar(),
      drawer: Container(
        margin: EdgeInsets.only(right:100),
        color:Colors.white,
        child: ListView(
          children: <Widget>[
            Container(


              height:300,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                ),


                accountName: Padding(
                  padding: const EdgeInsets.only(bottom:12),
                  child: Text("Nkanyiso"),
                ),
                accountEmail: Text("sgwnka001@myuct.ac.za"),
                currentAccountPicture:CircleAvatar(
                  radius:50,
                  backgroundImage:AssetImage("Picture/avatar.png") ,
                  backgroundColor: Colors.white,


                ),
              ),
            ),

            ListTile(
              title:Text("Sign out"),
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
      ),
      body:Column(
        children: <Widget>[
          Container(
            //margin:EdgeInsets.only(top:10),
              padding: EdgeInsets.only(top:10),
              color:Colors.grey[400],
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: ()async{
                      homeState.tab =0;
                      //print("yeah");
                      homeState.food= await Database().test();

                    },
                    child:Text(
                        "Burgers",
                        style:TextStyle(
                          letterSpacing: 2,

                        )

                    ),
                  ),
                  FlatButton(
                    onPressed: ()async{
                    await homeState.showPizza();
                  },
                    child:Text(
                        "Pizza",
                        style:TextStyle(
                          letterSpacing: 2,
                        )

                    ),
                  ),
                  FlatButton(
                    onPressed: ()async{

                      await homeState.showDrinks();
                    },
                    child:Text(
                        "Drinks",
                        style:TextStyle(
                          letterSpacing: 2,
                        )

                    ),

                  ),
                  FlatButton(
                    onPressed: ()async{
                      await homeState.showDessert();
                    },
                    child:Text(
                      "Dessert",
                      style:TextStyle(
                        letterSpacing: 2,
                      )


                    ),

                  )
                ],
              )
          ),
          if(homeState.tab==0)
            MyListView(foodAndConnect: foodAndConnect),

          if(homeState.tab==1)
            MyListView(foodAndConnect: homeState.pizzas),

          if(homeState.tab==2)
            MyListView(foodAndConnect: homeState.drinks),

          if(homeState.tab==3)
            MyListView(foodAndConnect: homeState.desserts),

          Container(
            color:Colors.grey[500],
            //height:50,
            child: Row(
              children: <Widget>[
                Expanded(

                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CheckOut())
                        );
                      });
                    },
                    child:Text(
                      "Check Out",
                      style:TextStyle(

                        letterSpacing: 2,
                      ),

                    ),
                    color: Colors.grey[500],


                  ),
                ),
              ],
            ),

          )

        ],


      ),

    );
  }
}

Widget MyAppBar(){

  return(
      PreferredSize(
           preferredSize: Size.fromHeight(60),// makes app bar taller

           child: AppBar(
              backgroundColor: Colors.grey[300],

              elevation: 0,
              title:Text(
                "Food and Connect",

                  style:TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      wordSpacing: 2,
                      letterSpacing: 2,

                    ),

              ),
              centerTitle: true,
              titleSpacing: 10,
      ),

  )
  );
}

