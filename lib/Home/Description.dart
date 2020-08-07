import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Models/FoodChosen.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Shared/Database.dart';
import 'package:flutter/src/widgets/framework.dart';


class Description extends StatefulWidget {

  final FoodItem food;

  Description({this.food});


  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  int count = 1;
  Auth _auth = Auth();


  @override
  Widget build(BuildContext context) {
    widget.food.quantity = count;

    return Container(
      child:Column(
        children: <Widget>[
          Text(
            widget.food.title,
            style:TextStyle(
              fontSize: 20,
              letterSpacing: 2,
            ),

          ),
          SizedBox(
              height:30
          ),

          Expanded(
            child: Image.network(
                widget.food.image,
                fit:BoxFit.cover,
            ),
          ),

          SizedBox(
              height:30
          ),
          Text(
            "R ${widget.food.price}",
            style:TextStyle(
              fontSize: 20,
              letterSpacing: 2,

            ),
          ),

          SizedBox(
              height:10
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: (){
                  setState(() {
                    count--;
                    widget.food.quantity = count;
                  });
                },
                child:Icon(
                  Icons.remove,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:0,horizontal: 20),
                child: Center(
                    child: Text(
                        "${widget.food.quantity}",
                      style:TextStyle(
                        letterSpacing: 2,
                      ),
                    )
                ),
              ),
              FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: (){
                  setState(() {
                    count++;
                    widget.food.quantity = count;
                  });
                },
                child:Icon(
                  Icons.add,
                ),
              ),

            ],
          ),
          SizedBox(
            height:20,
          ),

          FlatButton.icon(

            onPressed: (){
              print("user is ${_auth.toString()}");
              setState(() {
                count = 0;
              });
              _auth.updateUserData(widget.food,widget.food.id); //uploads order to database

              Navigator.pop(context);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Add to Cart",
                style:TextStyle(
                  color:Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            color:Colors.black,
          )
        ],
      ),
    );
  }
}
