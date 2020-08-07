

import 'package:flutter/material.dart';
import 'package:mymenu/Home/Description.dart';
import 'package:mymenu/Models/FoodItem.dart';

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

    //final foodAndConnect = Provider.of<List<Users>>(context); //?? [FoodItem(title:"none",price: 0.0,category: "none",id:"0",image:"https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg")];  // getting data from stream provider. ie there has been some change in the database
    //shouldLoad = foodAndConnect.length==1 ? false:true;
    return Container(
      child:Expanded(
        child: ListView.builder(
          //scrollDirection: Axis.horizontal,
          //shrinkWrap: true,
            itemCount: widget.foodAndConnect.length,
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20,0),
                child: Card(
                    color:Colors.grey[200],
                    child: ListTile(
                      onTap: (){
                        setState(() {
                          print(widget.foodAndConnect.length);
                          return _showSettingsPanel(widget.foodAndConnect[index]);
                        });
                      },
                      contentPadding: EdgeInsets.all(30),

                      title:Text(
                        widget.foodAndConnect[index].title ?? "No title",
                        style:TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w300,

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