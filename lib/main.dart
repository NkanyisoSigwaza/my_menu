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

void main(){

  WidgetsFlutterBinding.ensureInitialized();//helps with multiprovider
  runApp(
      MaterialApp(
    debugShowCheckedModeBanner: false,
    home:Main(),
  )
  );


}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  Widget build(BuildContext context) {


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