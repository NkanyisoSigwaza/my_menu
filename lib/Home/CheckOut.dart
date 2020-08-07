import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mymenu/Maps/MyMap.dart';
import 'package:mymenu/Models/Order.dart';
import 'package:mymenu/Authenticate/Auth.dart';
import 'package:mymenu/Shared/Database.dart';
import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/Shared/Price.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Auth _auth = Auth();
  var _user;

  @override
  // ignore: must_call_super
  void initState() {
    // This is the proper place to make the async calls
    // This way they only get called once

    // During development, if you change this code,
    // you will need to do a full restart instead of just a hot reload

    // You can't use async/await here,
    // We can't mark this method as async because of the @override
    _auth.inputData().then((user) {
      // If we need to rebuild the widget with the resulting data,
      // make sure to use `setState`
      setState(() {
        _user = user;
      });
    });
  }

  Widget build(BuildContext context) {
    
    Price price = Price();
    Auth _auth = Auth();



   //List<Order> orders = Provider.of<List<Order>>(context);



    return StreamBuilder(
      stream:Auth().myOrders(_user),
      builder:(context,snapshot) {

        if (!snapshot.hasData) {
          return Loading();
        }
        return Container(
          color: Colors.grey[100],
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Card(


                  child: Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 0),
                        child: Text(
                          "Total = R ${double.parse(
                              (price.calculatePrice(snapshot.data))
                                  .toStringAsFixed(2))}",
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            letterSpacing: 3,

                          ),

                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(

                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(

                                child: Card(
                                    color: Colors.grey[200],

                                    child: ListTile(
                                      onTap: () {

                                      },
                                      //leading:Image.network(orders[index].image),
                                      //contentPadding: EdgeInsets.all(30),
                                      trailing: FlatButton.icon(
                                          onPressed: () async {
                                            await _auth.deleteFromDb(
                                                snapshot.data[index].title);
                                            setState(() {

                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                          ),
                                          label: Text("Remove")

                                      ),

                                      title: Text(
                                        snapshot.data[index].title ??
                                            "No title",


                                        style: TextStyle(
                                          //fontSize: 15,
                                          //color:Colors.black,
                                          //decoration: TextDecoration.underline,

                                        ),

                                      ),

                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          "${snapshot.data[index]
                                              .quantity} X R${snapshot
                                              .data[index].price}",
                                          style: TextStyle(
                                            //fontSize: 25,
                                          ),
                                        ),
                                      ),

                                    ),
                                    elevation: 0),
                              ),
                            ),

                          ],
                        );
                      }
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  color: Colors.grey[300],
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton.icon(
                            color: Colors.grey[300],

                            onPressed: () async{
                              for(int i =0;i<snapshot.data.length;i++){
                                await Auth().checkOutApproved(snapshot.data[i]);
                              }
                              Position position = await Geolocator().getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                              await Database().loadLocation(position.latitude, position.longitude);

                              setState(() {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyMap())
                                );
                              });

                            },
                            icon: Icon(
                              Icons.add_shopping_cart,
                              size: 30,
                            )
                            ,
                            label: Text(
                              "Check Out!",
                              style: TextStyle(
                                fontSize: 20,
                              ),

                            )
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),

        );
      });
  }
}
