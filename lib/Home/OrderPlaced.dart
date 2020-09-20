
import 'package:flutter/material.dart';
import 'package:mymenu/Home/messageDriver.dart';
class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:Text(
            "Delivering your order",
        ),
        centerTitle: true,
      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: FlatButton.icon(

                  onPressed: (){
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => messageDriver())
                      );
                    });
                  },
                  icon: Icon(Icons.message),
                  label: Text(
                      "Message Driver",
                    style:TextStyle(
                      fontSize: 18
                    ) ,
                  )),
            ),
          )
        ],
      )
    );
  }
}
