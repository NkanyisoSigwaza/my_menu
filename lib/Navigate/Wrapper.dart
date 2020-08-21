
import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Authenticate.dart';

import 'package:mymenu/Models/User.dart';
import 'package:mymenu/Navigate/Director.dart';
import 'package:mymenu/Shared/Database.dart';
import 'package:mymenu/States/RestaurantState.dart';
import 'package:provider/provider.dart';
import 'package:mymenu/Home/Resturants.dart';
import 'package:mymenu/Home/Resturants.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); // acessing user data from provider
    // if it returns a user that means that that user is signed in (registered)

    if (user==null){
      // user not signed in
      return Authenticate();
    }
    else{
      // Bastard signed in!
      return StreamProvider.value(
        value: RestaurantState().numberRestaurants(),
          child: Resturants()
      );
    }


  }
}
