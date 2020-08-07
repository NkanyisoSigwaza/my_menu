import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,

        children:<Widget>[
          SizedBox(
            height:50,
          ),
      FlatButton(
          child:Text(
            "Buy Food",
            style:TextStyle(
              fontSize: 30,
            ),
          )
      ),
          FlatButton(
            child:Text(
                "Exchange voucher",
              style:TextStyle(
                fontSize: 30,
              ),
            )
          ),
          FlatButton(
              child:Text(
                "Budget",
                style:TextStyle(
                  fontSize: 30,
                ),
              )
          ),
        ],
      ),
    );

  }
}
