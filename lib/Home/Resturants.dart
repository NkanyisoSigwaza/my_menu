
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymenu/Models/Restuarant.dart';
import 'package:mymenu/Navigate/Director.dart';
import 'package:mymenu/Shared/Loading.dart';
import 'package:provider/provider.dart';

class Resturants extends StatefulWidget {
  @override
  _ResturantsState createState() => _ResturantsState();
}

class _ResturantsState extends State<Resturants> {
  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<List<Restaurant>>(context);
    return restaurants==null? Loading(): Scaffold(
      body: SafeArea(
        child: GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
          itemCount: restaurants.length,
            itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[

                  Expanded(
                    child: GestureDetector(
                      child: Card(
                        child: Image(
                          image:NetworkImage(restaurants[index].restaurantBackground ?? "https://www.bengi.nl/wp-content/uploads/2014/10/no-image-available1.png"),
                          fit:BoxFit.cover,
                        ),
                      ),
                      onTap: (){
                        setState(() {
                         Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => Director(restaurant: restaurants[index],))
                         );
                      });
                      },
                    ),
                  ),
                ]
              ),
            );
            }
        ),
      )
    );
  }
}
