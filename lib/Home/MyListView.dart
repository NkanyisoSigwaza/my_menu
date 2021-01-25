

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
    Size screenSize = MediaQuery.of(context).size;

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
      height:screenSize.height*0.7,


      child:ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.foodAndConnect.length,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20,20),
              child: Container(
                //height: 220,
                height: screenSize.height*0.3,

               // width:300,
                width:screenSize.width*0.1,
                child: GestureDetector(
                  onTap: (){

                   _showSettingsPanel(widget.foodAndConnect[index]);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                      color:Colors.black,
                      //color:Colors.grey[200],
                      child:Column(
                        children: [
                          Container(
                            height:MediaQuery.of(context).size.height*0.2,
                              width:MediaQuery.of(context).size.width*0.9,
                            child:Image(
                                image: NetworkImage(widget.foodAndConnect[index].image),
                                fit:BoxFit.cover
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    widget.foodAndConnect[index].title,
                                    style:TextStyle(
                                        fontSize: 25,
                                        color: Colors.white
                                    )
                                ),
                                Text(
                                    "R${widget.foodAndConnect[index].price.toStringAsFixed(2)}",
                                    style:TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,

                                    )
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),



                      elevation: 0),
                ),
              ),

            );
          }
      ),
    );


  }
}