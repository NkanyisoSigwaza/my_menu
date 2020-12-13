import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Models/Shop.dart';

class HomeState with ChangeNotifier{

  List<FoodItem> food = [];
  List<FoodItem> pizzas =[];
  List<FoodItem> desserts = [];
  List<FoodItem> drinks = [];
  int tab = 0;
  List<FoodItem> selectedCategory = [];


  // Displays pizza food items only
  showPizza()async{
    tab=1;
    Firestore.instance.collection("Food and Connect")
        .where("category",isEqualTo:"pizza")
        .getDocuments()
        .then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty) {
        pizzas = [];
        for(int pizza =0;pizza<docs.documents.length;pizza++){
          pizzas.add(

              FoodItem(
                  title :docs.documents[pizza].data["title"]?? "no",
                  image:docs.documents[pizza].data["image"] ?? "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
                  price : docs.documents[pizza].data["price"] ?? 0,
                  id : docs.documents[pizza].data["id"] ?? "ai",
                  category :docs.documents[pizza].data["category"] ?? "nja"
              )
          );


        }
        notifyListeners();
      }
      else{
        print("nah its empty bro!");

      }
    });

  }

  // Displays drink food items only
  showDrinks()async{
    tab=2;
    Firestore.instance.collection("Food and Connect")
        .where("category",isEqualTo:"drink")
        .getDocuments()
        .then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty) {
        drinks= [];
        for(int drink =0;drink<docs.documents.length;drink++){
          drinks.add(

              FoodItem(
                  title :docs.documents[drink].data["title"]?? "no",
                  image:docs.documents[drink].data["image"] ?? "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
                  price : docs.documents[drink].data["price"] ?? 0,
                  id : docs.documents[drink].data["id"] ?? "ai",
                  category :docs.documents[drink].data["category"] ?? "nja"
              )
          );
        }
        notifyListeners();
      }
      else{
        print("nah its empty bro!");

      }
    });


  }

  showDessert()async{
    tab=3;
    Firestore.instance.collection("Food and Connect")
        .where("category",isEqualTo:"dessert")
        .getDocuments()
        .then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty) {
        desserts= [];
        for(int dessert =0;dessert<docs.documents.length;dessert++){
          desserts.add(

              FoodItem(
                  title :docs.documents[dessert].data["title"]?? "no",
                  image:docs.documents[dessert].data["image"] ?? "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
                  price : docs.documents[dessert].data["price"] ?? 0,
                  id : docs.documents[dessert].data["id"] ?? "ai",
                  category :docs.documents[dessert].data["category"] ?? "nja"
              )
          );
        }
        notifyListeners();
      }
      else{
        print("nah its empty bro!");

      }
    });

  }

  List<FoodItem> _showSelectedCategory(QuerySnapshot snapshot){
   print("Here");
    print(snapshot);
    return [];
  }


  category(Shop shop, String category)async{
    print("Options/${shop.category}/${shop.category}/${shop.shopName}/Items");
    //selectedCategory = [];
    tab=1;

   await Firestore.instance.collection("Options").document(shop.category).collection(shop.category)
          .document(shop.shopName).collection("Items")
          .where("category",isEqualTo:category)
          .getDocuments().then((QuerySnapshot categoryItems){
      selectedCategory= [];
      for(int item =0;item<categoryItems.documents.length;item++){
        print(categoryItems.documents[item].data["category"]);
        selectedCategory.add(

            FoodItem(
                title :categoryItems.documents[item].data["title"]?? "no",
                image:categoryItems.documents[item].data["image"] ?? "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
                price : categoryItems.documents[item].data["price"] ?? 0,
                id :categoryItems.documents[item].data["id"] ?? "ai",
                category :categoryItems.documents[item].data["category"] ?? "nja"
            )
        );
      }
      notifyListeners();


   });

    await Future.delayed(const Duration(seconds: 1), () => "1");
    print(selectedCategory);
    notifyListeners();



    //       .forEach((element) {
    //
    //     element.forEach((key, value) {
    //       if (value["category"] == category) {
    //         selectedCategory.add(
    //             FoodItem(
    //                 title: value["title"],
    //                 price: value["price"],
    //                 image: value["image"],
    //                 category: value["category"],
    //                 shop: value["shop"],
    //                 id: value["id"]
    //             )
    //         );
    //       }
    //     });
    //   });
    //
    // }
    // catch(e){
    //
    // }
    // notifyListeners();


  //
  }






}