import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Models/Customer.dart';
import 'package:mymenu/Models/Promotion.dart';

class UserDrawerState with ChangeNotifier{
TextEditingController promoCode = TextEditingController();


  String validPromo = "";
  String name;
  String email;

  List<String> promos = ["promo1","promo2","promo3"];
  UserDrawerState(){
    customerInfo();
    //validPromo = "";
  }
  Future _findPromos() async{

    // ignore: missing_return
    Promotion promotion = await Firestore.instance.collection("Promotions").getDocuments().then((document){
        for(int elementIndex =0;elementIndex<document.documents.length;elementIndex++){
         // print("${document.documents[elementIndex].data["promoCode"]} VS ${promoCode.text}");
          if(promoCode.text==document.documents[elementIndex].data["promoCode"]){

          Promotion promo= Promotion(
            promoCode: document.documents[elementIndex].data["promoCode"],
            promoValue: document.documents[elementIndex].data["promoValue"]
          );

          return promo;
      }
        }


    });
    return promotion;
  }

  void verifyPromo()async{
    dynamic validPromoCheck = await _findPromos();
    await Future.delayed(const Duration(seconds: 1), () => "1");

    if (validPromoCheck !=null){
      validPromo = "Successfully added Promo!";


    promoCode.clear();
     notifyListeners();
    }
    else{

      validPromo = "Incorrect Promo!";
      promoCode.clear();
      notifyListeners();
    }
  }

  bool _isPromoValid(){
    for(int p=0;p<promos.length;p++){
      if(promoCode.text ==promos[p]){
        return true;
      }
    }
    return false;
  }



  Future<Customer> customerInfo()async{
    String uid = await Auth().inputData();
    return await Firestore.instance.collection("Users").document(uid).snapshots().forEach((element) {
      //print(element.data["email"]);
      Customer customer = Customer(
        name:element.data["name"],
        email: element.data["email"]
      );
      name = element.data["name"];
      email=element.data["email"];
      return customer;
    });


  }


  logUser(){
   FirebaseAnalytics().setCurrentScreen(screenName: "UserDrawerScreen");
   // FirebaseAnalytics().logEvent(name: "userDrawerOpened",parameters: {
   //   "name":name,
   //   "email":email
   // });


  }
  setOccupation(String occupation){
    FirebaseAnalytics().setUserProperty(
        name: "Ocupation", value: occupation);
  }

}