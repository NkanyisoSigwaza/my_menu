import 'package:flutter/material.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:provider/provider.dart';
class AfterCheckOut extends StatefulWidget {
  @override
  _AfterCheckOutState createState() => _AfterCheckOutState();
}

class _AfterCheckOutState extends State<AfterCheckOut> {

  @override
  Widget build(BuildContext context) {

    final shopsSeen = Provider.of<List<String>>(context);
    return shopsSeen==null ?Scaffold(
      appBar: AppBar(
        title:Text(
            "Order progress",
          style: TextStyle(
            letterSpacing: 2
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body:Column(

        children: [
          Center(
            child: Container(
                child: Text("Your order has been recorded")
            ),
          )
        ],
      )
    ):Scaffold(
        appBar: AppBar(
          title:Text(
            "Shop progress",
            style: TextStyle(
                letterSpacing: 2
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body:Column(
          mainAxisAlignment:MainAxisAlignment.center,

          children: [

            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: shopsSeen.length,
                itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: Text(
                      "${shopsSeen[index]} ",
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),

                  ),
                );
                }
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width*0.6,

                  child:Image(
                    image:AssetImage(
                        "Picture/preparingOrder.gif"
                    ),
                    fit: BoxFit.cover,
                  )

              ),
            ),
            FlatButton(
              onPressed: (){},
              child:Text(
                  "Track driver",
                style:TextStyle(
                  fontSize: 25
                )
              )
            ),
          ],
        )
    );
  }
}
