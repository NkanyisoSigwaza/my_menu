import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.black,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child:Image(
                image:AssetImage(
                    "Picture/delDocLogo.png"
                ),
              )
          ),
          Center(
            child: SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
