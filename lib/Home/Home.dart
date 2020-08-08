
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Authenticate/Authenticate.dart';
import 'package:mymenu/Authenticate/SignIn.dart';
import 'package:mymenu/Home/Budget.dart';
import 'package:mymenu/Home/CheckOut.dart';
import 'package:mymenu/Maps/MyMap.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Navigate/Wrapper.dart';

import 'package:mymenu/Shared/Database.dart';

import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/Home/MyListView.dart';

import 'package:provider/provider.dart';

import 'package:mymenu/VoucherHome/VoucherHome.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth _auth = Auth();
  List<FoodItem> food;

  List<FoodItem> pizza;
  List<FoodItem> dessert;
  List<FoodItem> drink;
  int tab = 0;
  @override
  Widget build(BuildContext context) {

    final foodAndConnect = Provider.of<List<FoodItem>>(context); //?? [FoodItem(title:"none",price: 0.0,category: "none",id:"0",image:"https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg")];  // getting data from stream provider. ie there has been some change in the database
    bool shouldLoad = foodAndConnect==null ? true:false; //false means data is ready




    return  shouldLoad? Loading():Scaffold(
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
              title:Text("Budget"),
              onTap: (){
                Navigator.of(context).pop();//closes menu in home pAGE
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Budget())
                );
              },
            ),
            Divider(
              height:5,
              color:Colors.black,
            ),
            ListTile(
              title:Text("Exchange Voucher"),
              onTap: (){
                Navigator.of(context).pop();//closes menu in home pAGE
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageCapture())
                );
              },
            ),
            Divider(
              height:5,
              color:Colors.black,
            ),
            ListTile(
              title:Text("Sign out"),
              onTap: (){
                _auth.signOut();
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
                      tab  =0;
                      //print("yeah");
                      food= await Database().test();
                      print(food);
                      setState(() {

                      });
                    },
                    child:Text(
                        "Burgers",
                        style:TextStyle(
                          letterSpacing: 2,

                        )

                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      tab=1;
                  Firestore.instance.collection("Food and Connect")
                  .where("category",isEqualTo:"pizza")
                  .getDocuments()
                  .then((QuerySnapshot docs){
                  if(docs.documents.isNotEmpty) {
                    pizza = [];


                  for(int i =0;i<docs.documents.length;i++){
                    pizza.add(

                        FoodItem(
                            title :docs.documents[i].data["title"]?? "no",
                            image:docs.documents[i].data["image"] ?? "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
                            price : docs.documents[i].data["price"] ?? 0,
                            id : docs.documents[i].data["id"] ?? "ai",
                            category :docs.documents[i].data["category"] ?? "nja"
                        )
                    );

                    print(docs.documents[i].data["title"]?? "no");
                   setState(() {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => MyListView(foodAndConnect:foods))
//                     );
                   });

                  }


                  }
                  else{
                  print("nah its empty bro!");

                  }
                  });

                  },
                    child:Text(
                        "Pizza",
                        style:TextStyle(
                          letterSpacing: 2,
                        )

                    ),
                  ),
                  FlatButton(
                    onPressed: (){

                      tab=2;
                      Firestore.instance.collection("Food and Connect")
                          .where("category",isEqualTo:"drink")
                          .getDocuments()
                          .then((QuerySnapshot docs){
                        if(docs.documents.isNotEmpty) {
                          drink= [];


                          for(int i =0;i<docs.documents.length;i++){
                            drink.add(

                                FoodItem(
                                    title :docs.documents[i].data["title"]?? "no",
                                    image:docs.documents[i].data["image"] ?? "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
                                    price : docs.documents[i].data["price"] ?? 0,
                                    id : docs.documents[i].data["id"] ?? "ai",
                                    category :docs.documents[i].data["category"] ?? "nja"
                                )
                            );

                            print(docs.documents[i].data["title"]?? "no");
                            setState(() {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => MyListView(foodAndConnect:foods))
//                     );
                            });

                          }


                        }
                        else{
                          print("nah its empty bro!");

                        }
                      });

                    },
                    child:Text(
                        "Drinks",
                        style:TextStyle(
                          letterSpacing: 2,
                        )

                    ),

                  ),
                  FlatButton(
                    onPressed: (){
                      tab=3;
                      Firestore.instance.collection("Food and Connect")
                          .where("category",isEqualTo:"dessert")
                          .getDocuments()
                          .then((QuerySnapshot docs){
                        if(docs.documents.isNotEmpty) {
                          dessert= [];


                          for(int i =0;i<docs.documents.length;i++){
                            dessert.add(

                                FoodItem(
                                    title :docs.documents[i].data["title"]?? "no",
                                    image:docs.documents[i].data["image"] ?? "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
                                    price : docs.documents[i].data["price"] ?? 0,
                                    id : docs.documents[i].data["id"] ?? "ai",
                                    category :docs.documents[i].data["category"] ?? "nja"
                                )
                            );

                            print(docs.documents[i].data["title"]?? "no");
                            setState(() {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => MyListView(foodAndConnect:foods))
//                     );
                            });

                          }


                        }
                        else{
                          print("nah its empty bro!");

                        }
                      });
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
          if(tab==0)
            MyListView(foodAndConnect: foodAndConnect),

          if(tab==1)
            MyListView(foodAndConnect: pizza),

          if(tab==2)
            MyListView(foodAndConnect: drink),

          if(tab==3)
            MyListView(foodAndConnect: dessert),

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
                        //color: Colors.white,
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
//              leading:IconButton(
//
//              onPressed: (){
//
//              },
//              icon:Icon(
//                  Icons.menu,
//                   size:30,
//
//              ),
//              color: Colors.black,
//              ),

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

