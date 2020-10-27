import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Home/Home.dart';
import 'package:mymenu/Home/Options.dart';
import 'package:mymenu/Home/Resturants.dart';
import 'package:mymenu/Maps/Models/LocationN.dart';
import 'package:mymenu/Maps/State/AppState.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Models/Order.dart';
import 'package:mymenu/Models/Restuarant.dart';
import 'package:mymenu/Models/User.dart';
import 'package:mymenu/Shared/Database.dart';
import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/States/DescriptionState.dart';
import 'package:mymenu/States/HomeState.dart';
import 'package:mymenu/States/RegisterState.dart';
import 'package:mymenu/States/RestaurantState.dart';
import 'package:mymenu/States/UserDrawerState.dart';
import 'package:provider/provider.dart';


class Director extends StatefulWidget {
  final Restaurant restaurant;



  Director({this.restaurant});
  @override
  _DirectorState createState() => _DirectorState();
}

class _DirectorState extends State<Director> {




  @override


  @override



  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        StreamProvider.value(value: RestaurantState().restaurantChosen(widget.restaurant.restaurantName)),
       // StreamProvider<List<FoodItem>>.value(value:Database().foodAndConnect(widget.resturant)),
        ChangeNotifierProvider.value(value: AppState()),
        ChangeNotifierProvider.value(value: HomeState()),
        ChangeNotifierProvider.value(value: DescriptionState()),
        ChangeNotifierProvider.value(value: RegisterState()),
        ChangeNotifierProvider.value(value: UserDrawerState()),
        StreamProvider<List<Restaurant>>.value(
            value: RestaurantState().numberRestaurants()),


        StreamProvider<List<LocationN>>.value(value:Database().DriverLocation()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Home(
        //   restaurant:widget.restaurant
        // ),
     home:Home(restaurant:widget.restaurant),
      ),
    );

  }
}

