import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Maps/Models/LocationN.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Models/Restuarant.dart';



class Database{







  List<FoodItem> burgers;


  //collection reference allows us to access a firestore collection [database]
  final CollectionReference foodAndConnectCollection = Firestore.instance.collection("Food and Connect");

// can read documents in the collection using that reference




// Sends users location to driver
  Future loadLocation(double latitude,double longitude)async{
    String uid = await Auth().inputData();
    return await Firestore.instance.collection("Location").document(uid).setData({


      "latitude":latitude,
      "longitude":longitude,

    });

  }


//-------------------------------------------------------------------------------------------------------------------------------------//



  // returns only burgers from food and connect

  Future  test() async{



    foodAndConnectCollection
        .where("category",isEqualTo:"Burger")
        .getDocuments()
        .then((QuerySnapshot docs){
         if(docs.documents.isNotEmpty) {
            List<FoodItem> foods = [];

           for(int i =0;i<docs.documents.length;i++){

                foods.add(

                     FoodItem(
                         title :docs.documents[i].data["title"]?? "no",
                         image:docs.documents[i].data["image"] ?? "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
                         price : docs.documents[i].data["price"] ?? 0,
                         id : docs.documents[i].data["id"] ?? "ai",
                         category :docs.documents[i].data["category"] ?? "nja",
                         shop: docs.documents[i].data["restaurant"] ?? "nja"
                     )
                 );
             print(docs.documents[i].data["title"]?? "no");
           }
            return foods;
           burgers = foods;
         }
         else{
           print("nah its empty bro!");
           return null;
         }
  });
    return burgers;
  }
 void tired() {


   Firestore.instance
       .collection('Food And Connect')
       .where("category", isEqualTo: "Burger")
       .snapshots()
       .listen((data) =>
       data.documents.forEach((doc) => print("title")));
 }

  List<LocationN> _locationFromSnapshot(QuerySnapshot snapshot){


    return snapshot.documents.map((doc){
      // returning a brew object for each document
      return LocationN(

        lat:doc.data["latitude"] ?? -28.5556216, // if doesn't exist give it an empty string
        long: doc.data["longitude"] ?? 29.7773499,

      );
    }).toList();

  }
  Stream<List<LocationN>> DriverLocation(){
    return Firestore.instance.collection("Location").snapshots().map(_locationFromSnapshot);

  }






}





