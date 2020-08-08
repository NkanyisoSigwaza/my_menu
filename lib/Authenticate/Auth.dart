
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymenu/Models/ConfirmCheckOut.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Models/Order.dart';
import 'package:mymenu/Models/User.dart';


class Auth{
  //allows us to use firebase authentication -- line below
  final FirebaseAuth _auth = FirebaseAuth.instance;  //_ means private in variable auth

  String uid;
  //List<Order> orders = [Order(image: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg",price: 0,food_id: "placeholder")];
  //create user object based on Firebase user
  List<ConfirmCheckOut> orders = [];
  User _userFromFireBaseUser(FirebaseUser user){
    return user!=null ? User(userId: user.uid) : null;
  }
  // auth change user stream


  Stream< User> get user{
    //tells us each time user signs in / out
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }
  

  //sign in with email and password



  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print("________________________________no SIGN OUT $e");
      return null;

    }
  }

  //users connecting to database
  final CollectionReference orderCollection = Firestore.instance.collection("Orders");



  //CB and edit
  Future checkOutApproved(ConfirmCheckOut food) async{



    uid = await inputData();
    // print(uid);


    return await Firestore.instance.collection("OrdersRefined").document(uid).updateData(
        {
          "${food.title}.checkOut": "Yes"
        });


  }

  List<ConfirmCheckOut> _ordersFromSnapshot(DocumentSnapshot snapshot) {

    //String uid = await inputData();


    //print(snapshot.data);
    snapshot.data.keys.forEach((element) {
      //print(snapshot.data[element]);
      try {

        if(snapshot[element]["inActive"]==1 && snapshot[element]["checkOut"]!="Yes"){
          // print(snapshot['$i']);
          orders.add(ConfirmCheckOut(
            title: snapshot[element]["title"],
            price:snapshot[element]["price"],
            quantity: snapshot[element]["quantity"],
            time: snapshot[element]["date"]
          ));

          // print(snapshot['$i']);
        }
      }
      catch(e){
        print(e);
      }
    });
   // print(firstKey);
    //print(snapshot.data[firstKey]);

   // dynamic nka= snapshot.data;
//    int size = snapshot.data.length;
//
//
//    for (int i=1; i < size+1; i++) {
////      if(snapshot['$i']["inActive"]=="1"){
////        print(snapshot['$i']);
////      }
//      try {
//
//        if(snapshot['$i']["inActive"]=="1"){
//         // print(snapshot['$i']);
//          orders.add(Order(
//            title: snapshot['$i']["title"],
//            price:snapshot['$i']["price"],
//            image:snapshot['$i']["image"],
//            food_id:"yer" ,
//            numOrders: i,
//          ));
//
//         // print(snapshot['$i']);
//         }
//      }
//      catch(e){
//        print(e);
//      }
//      }



//    print(snapshot.data['1'][
//      'image'
//    ]);



//    return snapshot.documents.map((doc){
//      // returning a brew object for each document

//      return Order(
//        title:doc.data["title"] ?? "", // if doesn't exist give it an empty string
//        price: doc.data["price"] ?? 0,
//
//        image: doc.data["image"] ?? "",
//        food_id:doc.data["id"] ?? "0",
//        quantity: doc.data["quantity"] ?? 1,
//
//
//      );
//    }).toList();
  return orders;

  }



//  Stream<List<Order>> get orders {
//    //returns snapshot of database and tells us of any changes [provider]
//    return orderCollection.snapshots().map(_ordersFromSnapshot);
//  }

  Stream<List<ConfirmCheckOut>> myOrders(String user) {
    //returns snapshot of database and tells us of any changes [provider]

    return Firestore.instance.collection("OrdersRefined").document(user).snapshots().map(_ordersFromSnapshot);
  }


  Future deleteFromDb(String id) async{
    String uid = await inputData();
    try {
      DocumentReference doc = Firestore.instance.collection("OrdersRefined")
          .document(uid);
       doc.updateData({ id: FieldValue.delete()});
    }
    catch(e){
      print(e);
      return null;
    }
  }

  Future inputData() async {
    final FirebaseUser user = await _auth.currentUser();

    return user.uid;
    // here you write the codes to input the data into firestore
  }
}