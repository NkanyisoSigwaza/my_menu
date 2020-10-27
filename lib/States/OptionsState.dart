
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

class OptionsState with ChangeNotifier{

  OptionsState(){

  }


  logOptionScreen(String category){
    FirebaseAnalytics().logEvent(name: "SelectedCategory",parameters: {
      "Category":category,
    });


  }









}