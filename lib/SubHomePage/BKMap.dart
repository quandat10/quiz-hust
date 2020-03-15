import 'package:bker_sos/HomePage.dart';
import 'package:bker_sos/View/loadingpage.dart';
import 'package:flutter/material.dart';
import 'package:bker_sos/View/CustomIcons.dart';
import 'package:bker_sos/Controller/dataBKMap.dart';
import 'package:bker_sos/Controller/CardScrollWidget.dart';
import 'dart:math';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class BKMap extends StatefulWidget{
  @override
  _BKMapState createState() => _BKMapState();
}
var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio  = cardAspectRatio * 1.2;
class _BKMapState extends State<BKMap>{
  Uint8List imageFile;
  int MAX_SIZE = 1024 * 1024;
  StorageReference map = FirebaseStorage.instance.ref().child("BKMap");
  getImage(){
    map.child("bkmap.png").getData(MAX_SIZE).then((data){
      setState(() {
        imageFile = data;
      });
    });
  }
  @override
  void initState(){
    super.initState();
    getImage();
  }
  Widget loadImage(){
    if(imageFile == null){
      return LoadingPage();
    }else{
      return Image.memory(imageFile, fit: BoxFit.fitWidth,
      height: 200.0,
      width: 350.0,);
    }
  }
  var currentPage = images.length - 1.0;
  @override
  Widget build(BuildContext context) {
    PageController controller = new PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    }

    );

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(165, 42, 42, 0.8),
                Color.fromRGBO(165, 42, 42, 1),

              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromRGBO(165, 42, 42, 0.8),
          title: Text(
            "BK Map",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0, bottom: 8.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Khoa - Viện",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontFamily: "SVN-Santis",
                          letterSpacing: 1.0,
                        )),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFff6e6e),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("3 Khoa",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text("16 Viện",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: images.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Column(

                        );

                      },
                    ),
                  )
                ],
              ),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Bản Đồ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontFamily: "SVN-Santis",
                          letterSpacing: 1.0,
                        )),
//                    IconButton(
//                      icon: Icon(
//                        CustomIcons.option,
//                        size: 12.0,
//                        color: Colors.white,
//                      ),
//                      onPressed: () {},
//                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("3 cổng",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text("20+ Toà",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: loadImage()
                    ),
                  )
                ],
              )
            ],
          ),
        ),

      ),
    );
  }
}


