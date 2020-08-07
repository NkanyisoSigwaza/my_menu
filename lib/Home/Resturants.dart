
import 'package:flutter/material.dart';
import 'package:mymenu/Navigate/Director.dart';

class Resturants extends StatefulWidget {
  @override
  _ResturantsState createState() => _ResturantsState();
}

class _ResturantsState extends State<Resturants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FlatButton(
              child:Text("Food and connect"),
              onPressed:(){
                setState(() {
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => Director(resturant: "Food and Connect",))
                   );
                });
              },

            ),

            FlatButton(
              child:Text("Dine with us"),
              onPressed:(){
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Director(resturant: "Dine with us",))
                  );
                });
              },
            ),
          ],
        ),
      )
    );
  }
}
