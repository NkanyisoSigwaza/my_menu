import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymenu/Home/Home.dart';


import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Models/Order.dart';
import 'package:mymenu/Models/User.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Shared/Database.dart';
import 'package:mymenu/Navigate/Wrapper.dart';
import 'package:mymenu/VoucherHome/VoucherHome.dart';

import 'package:provider/provider.dart';
import 'package:mymenu/Maps/MyMap.dart';

import 'Services/firebase_analytics.dart';

void main(){

  WidgetsFlutterBinding.ensureInitialized();//helps with multiprovider
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorObservers: [observer],
    home:Main(analytics:analytics,observer:observer),
  )
  );


}

class Main extends StatefulWidget {

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;


  Main({this.analytics,this.observer });
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {


  Future _sendAnalytics()async{
    await widget.analytics.logEvent(
          name: 'test_event',
          parameters: <String, dynamic>{
            'string': 'string',
            'int': 42,
            'long': 12345678910,
            'double': 42.0,
            'bool': true,
          },
        );
        print('logEvent succeeded');

    print("_______________________________DONE___________________");
  }

//  Future<Null>_currentScreen()async{
//    await widget.analytics.setCurrentScreen(
//        screenName: "Wall_Screen ",
//      screenClassOverride: "WallScreen"
//    );
//  }
  @override
  Widget build(BuildContext context) {

   // _currentScreen();
    _sendAnalytics();
    return StreamProvider<User>.value(
      //providing stream to root widget
      //actively listening to auth requests user sign in/out
      value:Auth().user, // whether user signed in or not
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Wrapper(),

      ),
    );;
  }
}