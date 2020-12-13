
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
import 'package:mymenu/Models/Restuarant.dart';
import 'package:mymenu/Models/Shop.dart';
import 'package:mymenu/Navigate/Wrapper.dart';

import 'package:mymenu/Shared/Database.dart';

import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/Home/MyListView.dart';
import 'package:mymenu/Shared/UserDrawer.dart';
import 'package:mymenu/States/HomeState.dart';

import 'package:provider/provider.dart';
import "package:mymenu/Services/firebase_analytics.dart";

import 'package:mymenu/VoucherHome/VoucherHome.dart';


class Home extends StatefulWidget {

  Shop shop;

  Home({this.shop});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
//    analytics.logLogin();
//    analytics.logEvent(name: "Restaurant Screen");
  List<String> words = [
    "one","two","three","four","five","one","two","three","four","five","one","two","three","four","five"
  ];

    final foodItems = Provider.of<List<FoodItem>>(context);
    final homeState = Provider.of<HomeState>(context);



    return  foodItems==null ? Loading():Scaffold(
      //backgroundColor: Colors.grey[100],
        backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),// makes app bar taller

        child: Padding(
          padding: const EdgeInsets.only(top:24),
          child: Container(
            child: AppBar(
             //backgroundColor: Colors.red[500],
              backgroundColor: Colors.white,

              elevation: 0,
              title:Text(
                foodItems[0].shop,

                style:TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  wordSpacing: 2,
                  letterSpacing: 2,

                ),

              ),
              centerTitle: true,

            ),
          ),
        ),

      ),
      drawer:UserDrawer(),
      body:Column(
        children: <Widget>[
          // Container(
          //   //margin:EdgeInsets.only(top:10),
          //     padding: EdgeInsets.only(top:10),
          //    // color:Colors.grey[400],
          //     child:Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         OutlineButton(
          //
          //           borderSide: BorderSide(
          //               color:Colors.grey
          //           ),
          //
          //           shape:RoundedRectangleBorder(
          //
          //             borderRadius: BorderRadius.circular(30),
          //           ),
          //           onPressed: ()async{
          //             homeState.tab =0;
          //             //print("yeah");
          //             homeState.food= await Database().test();
          //
          //           },
          //           child:Text(
          //               "Burgers",
          //               style:TextStyle(
          //                 letterSpacing: 2,
          //
          //               )
          //
          //           ),
          //         ),
          //         OutlineButton(
          //           borderSide: BorderSide(
          //               color:Colors.grey
          //           ),
          //
          //           shape:RoundedRectangleBorder(
          //
          //             borderRadius: BorderRadius.circular(30),
          //           ),
          //           onPressed: ()async{
          //           await homeState.showPizza();
          //         },
          //           child:Text(
          //               "Pizza",
          //               style:TextStyle(
          //                 letterSpacing: 2,
          //               )
          //
          //           ),
          //         ),
          //         OutlineButton(
          //           borderSide: BorderSide(
          //               color:Colors.grey
          //           ),
          //
          //           shape:RoundedRectangleBorder(
          //
          //             borderRadius: BorderRadius.circular(30),
          //           ),
          //           onPressed: ()async{
          //
          //             await homeState.showDrinks();
          //           },
          //           child:Text(
          //               "Drinks",
          //               style:TextStyle(
          //                 letterSpacing: 2,
          //               )
          //
          //           ),
          //
          //         ),
          //         OutlineButton(
          //           borderSide: BorderSide(
          //               color:Colors.grey
          //           ),
          //
          //           shape:RoundedRectangleBorder(
          //
          //             borderRadius: BorderRadius.circular(30),
          //           ),
          //           onPressed: ()async{
          //             await homeState.showDessert();
          //           },
          //           child:Text(
          //             "Dessert",
          //             style:TextStyle(
          //               letterSpacing: 2,
          //             )
          //
          //
          //           ),
          //
          //         )
          //       ],
          //     )
          // ),
          Container(
            height: 50,
            width: 600,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.shop.categories.length,
                itemBuilder: (context,index){
                return GestureDetector(
                  child: OutlineButton(
                    borderSide: BorderSide(
                        color:Colors.grey
                    ),

                    shape:RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: ()async{
                      await homeState.category(widget.shop, widget.shop.categories[index]);

                      print(homeState.selectedCategory);

                      return MyListView(foodAndConnect: homeState.selectedCategory);

                    },
                    child:Text(
                        widget.shop.categories[index],
                        style:TextStyle(
                          letterSpacing: 2,
                        )


                    ),

                  ),
                  onTap: ()async{
                  // await homeState.category(widget.shop.shopName, widget.shop.categories[index]);
                  },
                );
                }),
          ),
        SizedBox(
          height:10
        ),
          if(homeState.tab==0)
            MyListView(foodAndConnect: foodItems),

          if(homeState.tab==1)
            MyListView(foodAndConnect: homeState.selectedCategory),

          if(homeState.tab==2)
            MyListView(foodAndConnect: homeState.drinks),

          if(homeState.tab==3)
            MyListView(foodAndConnect: homeState.desserts),

          Container(
            width:165,
            //color:Colors.grey[500],
            color: Colors.black,
            //height:50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
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
                      fontSize: 20,

                      letterSpacing: 2,
                      color: Colors.white
                    ),

                  ),
                  color: Colors.red[900],



                ),
              ],
            ),

          )

        ],


      ),

    );
  }
}



