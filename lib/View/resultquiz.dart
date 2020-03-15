import 'dart:typed_data';

import 'package:bker_sos/Controller/CardScrollWidget.dart';
import 'package:bker_sos/SubHomePage/FirstTest.dart';
import 'package:bker_sos/View/loadingpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
class ResultPage extends StatefulWidget{
  int marks;
  ResultPage({Key key, @required this.marks}) : super (key : key);
  @override
  _resultPageState createState() => _resultPageState(marks);
}
class _resultPageState extends State<ResultPage>{
  Uint8List imageFile;
  StorageReference bad = FirebaseStorage.instance.ref().child("ResultQuiz");
  StorageReference good = FirebaseStorage.instance.ref().child("ResultQuiz");
  getImage(){
    int MAX_SIZE = 70 * 1024;
    if(marks < 20){
      bad.child("bad.png").getData(MAX_SIZE).then((data){
        this.setState((){
          imageFile = data;
        });
      }).catchError((error){

      });
    }else{
      good.child("good.png").getData(MAX_SIZE).then((data){
        this.setState((){
          imageFile = data;
        });
      }).catchError((error){

      });
    }


  }
  Widget decideGridTitleWidget(){
    if(imageFile == null){
      return Center(child: Text("No data"),);
    }else{
      return Image.memory(imageFile, fit: BoxFit.cover,);
    }
  }
  List<String> images = [
    "images/good.png",
    "images/bad.png"
  ];
  int marks;
  _resultPageState(this.marks);
  String message;
  String image;
  @override
  void initState(){
    super.initState();
    getImage();
//    if(marks < 20){
//        image = images[1];
//    }else{
//        image = images[0];
//    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(165, 42, 42, 0.8),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    decideGridTitleWidget(),
                    Text(
                      "Điểm số của bạn là : $marks",
                      style: TextStyle(
                        fontFamily: "Quando",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Color.fromRGBO(255, 64, 64, .4),
                    child:  OutlineButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context ) => FirstTest(),
                        ));
                      },
                      child: Text(
                        "Tiếp tục",

                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontFamily: "Quando"
                        ),
                      ),


                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 16.0
                      ),

                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


