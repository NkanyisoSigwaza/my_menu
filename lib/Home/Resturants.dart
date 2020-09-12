
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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Text(
              "Home",
            style:TextStyle(
              fontSize: 30,
            )
          ),
          backgroundColor: Colors.red[900],
          centerTitle: true,
        ),
      ),

      body: SafeArea(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "New",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    fontStyle:FontStyle.italic,


                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:30),
              child: Container(
                color: Colors.black,
                height:150,
                width:MediaQuery.of(context).size.width,
                child: ListView.builder(
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:restaurants.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: GestureDetector(
                          child: Container(
                            //width:300,
                           // height:600,
                            child: Card(
                             // color:Colors.black,
                              shape:RoundedRectangleBorder(

                                borderRadius: BorderRadius.circular(60),
                          ),
                              child: Image(
                                image:NetworkImage(restaurants[index].restaurantBackground ?? "https://www.bengi.nl/wp-content/uploads/2014/10/no-image-available1.png"),
                                fit:BoxFit.cover,
                              ),
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
                      );
                    }),
              ),
            ),
//            SizedBox(
//              height:50
//            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,20,20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "All Restaurants",
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    fontStyle:FontStyle.italic,


                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                itemCount: restaurants.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,20),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children:[
//                      Text(
//                        restaurants[index].restaurantName,
//                        style: TextStyle(
//                          fontSize:25
//                        ),
//                      ),
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              //width:300,
                              //height:600,
                              margin:EdgeInsets.all(20),



                              child: Card(
                                //color:Colors.black,
                                child: Image(
                                  image:NetworkImage(restaurants[index].restaurantBackground ?? "https://www.bengi.nl/wp-content/uploads/2014/10/no-image-available1.png"),
                                  fit:BoxFit.cover,
                                ),
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
            ),
//            Container(
//                width: MediaQuery.of(context).size.width,
//                //height: 500,
//                color:Colors.red[900],
//              child: Row(
//                children: [
//                  FlatButton.icon(
//                      onPressed: (){},
//                      icon: Icon(Icons.home),
//                      label: Text("Home")
//                  )
//                ],
//              ),
//            ),
          ],
        ),
      )
    );
  }
}
