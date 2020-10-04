import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Models/Customer.dart';

class UserDrawerState with ChangeNotifier{

  String name;
  String email;
  UserDrawerState(){
    customerInfo();
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




}