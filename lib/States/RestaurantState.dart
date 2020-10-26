import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Models/Restuarant.dart';



class RestaurantState with ChangeNotifier{

  List<FoodItem> food =[];

  RestaurantState();


// GETS RESTAURANT MENU

  List<FoodItem> _restaurantChosenFromSnapshot(DocumentSnapshot snapshot){

    try{
      snapshot.data.keys.forEach((element) {
        food.add(new FoodItem(
          title: snapshot[element]["title"],
          price: snapshot[element]["price"],
          category: snapshot[element]["category"],
          restaurant: snapshot[element]["restaurant"],
          image: snapshot[element]["image"],
          id:snapshot[element]["id"],

        ));
      });
    }
    catch(e){

    }
    return food;

  }

  Stream<List<FoodItem>> restaurantChosen(String restaurant){
    //returns snapshot of database and tells us of any changes [provider]
    return Firestore.instance.collection("Restaurants").document(restaurant).snapshots().map(_restaurantChosenFromSnapshot);
  }


  // RETURNS ALL RESTAURANTS IN DATABASE

  List<Restaurant> _numRestaurants(QuerySnapshot snapshot){


    return snapshot.documents.map((doc){

      print("categories______________________-${doc.data["categories"]}");
      // returning a brew object for each document
      return Restaurant(
          restaurantName: doc.documentID,
          restaurantBackground: doc.data["picture"],
          categories: doc.data["categories"]
      );
    }).toList();
  }


  Stream<List<Restaurant>> numberRestaurants(){

    //returns snapshot of database and tells us of any changes [provider]
    return Firestore.instance.collection("Restaurants").snapshots().map( _numRestaurants);
  }

  logShopSelected(String shop) {
    FirebaseAnalytics().logEvent(name: "Selected Shop", parameters: {
      "Shop": shop,
    });
  }




}