import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Controller/GridDashBoard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(165, 42, 42, .8),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40.0,),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SvgPicture.asset("assets/home-24px.svg",
                        color: Colors.white,),
                        Text("  Home",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: "Satisfy"
                        ),)
                      ],
                    )
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon : SvgPicture.asset("assets/bell.svg",
                  width: 25.0,
                  height: 25.0,),
                  onPressed: (){

                  },
                )
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          GridDashBoard()
        ],
      ),
    );
  }
}