import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AfterCheckOutState with ChangeNotifier{
bool orderSeen = false;
String shop;

List<String>  _progressFromShop(DocumentSnapshot snapshot){
 List<String> all =[];


 snapshot.data.keys.forEach((element) {

  try {

   if(snapshot[element]["active"]==1 && snapshot[element]["shopSeen"]=="Yes"){

    print('shopSeen: snapshot[element]["shopSeen"]');
    print(snapshot[element]["active"]);
    print(snapshot[element]["shop"]);


    if(shop==null){
     if(snapshot[element]["orderCollected"]=="Yes"){
      shop = "your order at "+snapshot[element]["shop"]+" has been collected by driver";
     }
     else{
      shop = snapshot[element]["shop"]+" is preparing your order!";
     }

     all.add(shop);
    }
    else if(shop == snapshot[element]["shop"] ){


    }
    else {
     if(snapshot[element]["orderCollected"]=="Yes"){
      shop = "your order at "+snapshot[element]["shop"]+" has been collected by driver";
     }
     else{
      shop = snapshot[element]["shop"]+" is preparing your order!";
     }

     all.add(shop);
    }
    print(all);


   }
  }
  catch(e){
   print(e);
  }
 });

 List shops =all.toSet().toList();
 // shop = '';
 // for(int i=0;i<shops.length;i++){
 //  if(i <shops.length -1){
 //   shop += shops[i] + ' & ';
 //  }
 //  else{
 //   shop += shops[i];
 //  }
 //
 // }

print(shops);


 return shops;

}







Stream<List<String>> getShopProgress({String uid}){
 return Firestore.instance.collection('OrdersRefined').document(uid).snapshots().map(_progressFromShop);
}


  
}