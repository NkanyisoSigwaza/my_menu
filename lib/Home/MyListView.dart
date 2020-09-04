

import 'package:flutter/material.dart';
import 'package:mymenu/Home/Description.dart';
import 'package:mymenu/Models/FoodItem.dart';
import 'package:mymenu/Shared/Loading.dart';

import 'package:provider/provider.dart';

class MyListView extends StatefulWidget {
  List<FoodItem> foodAndConnect;

  MyListView({this.foodAndConnect});
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(FoodItem food){
      showModalBottomSheet(context: context, builder:(context){
        //builder shows widget tree to display in bottom sheet
        return Container(
          padding:EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child:Description(food:food),
        );
      });
    }

    return widget.foodAndConnect.length==0?
    Loading(): Container(
      child:Expanded(
        child: ListView.builder(
          //scrollDirection: Axis.horizontal,
          //shrinkWrap: true,
            itemCount: widget.foodAndConnect.length,
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20,0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                    color:Colors.black,
                    //color:Colors.grey[200],
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          return _showSettingsPanel(widget.foodAndConnect[index]);
                        });
                      },
                      contentPadding: EdgeInsets.all(40),

                      title:Text(
                        widget.foodAndConnect[index].title ?? "No title",
                        style:TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w300,
                          color:Colors.white

                        ),

                      ),
                      trailing:Image.network(widget.foodAndConnect[index].image),
                      subtitle:Padding(
                        padding: const EdgeInsets.only(top:30),
                        child: Text(
                          " R${widget.foodAndConnect[index].price}",
                          style:TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w200,
                              color:Colors.white
                          ),
                        ),
                      ),

                    ),
                    elevation: 0),

              );
            }
        ),
      ),
    );


  }
}