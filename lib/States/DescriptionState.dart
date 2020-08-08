

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Models/User.dart';

class DescriptionState with ChangeNotifier{
  int count = 1;
  final FirebaseAuth _auth= FirebaseAuth.instance;

  // adds quantity of food
 int addQuantity(){
   count++;
    return count;
 }
// decreases quantity of food
  int decreaseQuantity(){
    count--;
    return count;
  }

  // Returns user object which contains firebaseID
  User _userFromFireBaseUser(FirebaseUser user){
    return user!=null ? User(userId: user.uid) : null;
  }

  Future userId() async {
    final FirebaseUser user = await _auth.currentUser();

    return user.uid;
    // here you write the codes to input the data into firestore
  }

  //saves user orders to database
  Future updateUserData(FoodItem food,String id) async{

    var uid = await userId();


    var docData = {
      "${food.title}":{
        "title":food.title,
        "price":food.price,
        "quantity":food.quantity,
        "image":food.image,
        "inActive":1,
        "date":DateTime.now(),
        "restaurant":food.restaurant,
        "checkOut":"No"
      }
    };


    return await Firestore.instance.collection("OrdersRefined").document(uid).setData(docData,merge: true);


  }


}