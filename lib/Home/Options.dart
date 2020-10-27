import 'package:flutter/material.dart';
import 'package:mymenu/Models/Option.dart';
import 'package:mymenu/Models/Restuarant.dart';
import 'package:mymenu/Navigate/Director.dart';
import 'package:mymenu/Shared/Loading.dart';
import 'package:mymenu/Shared/UserDrawer.dart';
import 'package:mymenu/States/OptionsState.dart';
import 'package:mymenu/States/RestaurantState.dart';
import 'package:provider/provider.dart';

import 'Resturants.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  List<Option> options = [
    Option(category: "Food",url:"https://www.helpguide.org/wp-content/uploads/fast-foods-candy-cookies-pastries-768.jpg"),
    Option(category:"Liquor",url:"https://www.sabcnews.com/sabcnews/wp-content/uploads/2020/07/sabc-news-alcohol-R.jpg"),
    Option(category:"Gifts",url:"https://static.zando.co.za/cms/gift-ideas/Gift-ideas-gifts-for-dad.jpg")
  ];
  @override
  Widget build(BuildContext context) {
    final optionsState = Provider.of<OptionsState>(context);
    return Scaffold(
      drawer: UserDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title:Text(
              "Categories",
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 23
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Container(
                  child: Text(
                    "What would you like?",
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 34,
                      letterSpacing: 3,
                    ),
                      ),
                ),
              ),
              SizedBox(
                height:40
              ),
              GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,20),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                      Text(
                        options[index].category,
                        style: TextStyle(
                          fontSize:30,
                          color: Colors.amber,
                          letterSpacing: 2
                        ),
                      ),
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  //width:300,
                                  //height:600,
                                  margin:EdgeInsets.all(20),



                                  child: CircleAvatar(
                                    backgroundImage:NetworkImage(options[index].url ?? "https://www.bengi.nl/wp-content/uploads/2014/10/no-image-available1.png"),
                                    radius:55,
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    optionsState.logOptionScreen(options[index].category);
    if(options[index].category=="Food") {


    Navigator.push(context,MaterialPageRoute(builder: (context){
      return MultiProvider(
        providers:[StreamProvider<List<Restaurant>>.value(
            value: RestaurantState().numberRestaurants(),
        ),
          ChangeNotifierProvider.value(value: RestaurantState())],
        child: Resturants(),
      );}));
//                                      return StreamProvider.value(
//                                          value: RestaurantState().numberRestaurants(),
//                                          child: Resturants()
//                                      );
    }
    else{
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Loading()));

    }
    });
                                      }
                                
                                      ,
                              ),
                            ),

                          ]
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
