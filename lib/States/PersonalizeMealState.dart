

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Models/Meal.dart';

class PersonalizeMealState{


  //saves user orders to database
  Future updateUserData(Meal meal) async{

    var uid = await Auth().inputData();


    List<String> selectedOptions = [];
    for(int option=0;option<meal.selected.length;option++){
      selectedOptions.add(meal.selected[option].title);
    }


    var docData = {
      "${meal.title}":{
        "title":meal.title,
        "price":meal.finalPrice,
        "category":"Meal",
        "selectedOptions":selectedOptions,
        "quantity":1,
        "image":meal.image,
        "inActive":1,
        "date":DateTime.now(),
        "shop":meal.shop,
        "checkOut":"No",
        "driverSeen":null,
        "restaurantSeen":null
      }

    };




    return await Firestore.instance.collection("OrdersRefined").document(uid).setData(docData,merge: true);


  }








}