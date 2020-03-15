
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bker_sos/View/quizzapp.dart';

import 'package:flutter_svg/flutter_svg.dart';

class FirstTest extends StatefulWidget{
  int idx;
  @override
  _firstTestState createState() => _firstTestState();
}
class _firstTestState extends State<FirstTest>{

  List<String> images = [
    'assets/figure1.svg',
    'assets/figure2.svg',
    'assets/figure3.svg',
    'assets/figure4.svg',
    'assets/figure5.svg',

  ];

  Widget customcard(String name, String image){
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => getjson(),
          ));
        },
        child: Material(
          color: Color.fromRGBO(255, 64, 64, .4),
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 200.0,
                      width: 200.0,
                      child: ClipOval(
                        child: SvgPicture.asset(image)
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontFamily: "Alike",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Ai la nguoi dau tien len mat trang ?",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontFamily: "Alike"
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(165, 42, 42, 0.8),
        title: Text(
          "Kiểm tra quy chế",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0
          ),
        ),
      ),
      backgroundColor:  Color.fromRGBO(165, 42, 42, 0.8),
      body: CustomScrollView(
              slivers: <Widget>[

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 20.0,),
                      customcard("Đề 1",images[0]),
                      customcard("Đề 2",images[1]),
                      customcard("Đề 3",images[2]),
                      customcard("Đề 4",images[3]),
                      customcard("Đề 5",images[4]),
                    ]
                  ),
               )
              ],
    ),
//      ListView(
//        children: <Widget>[
//          customcard("Đề 1",images[0]),
//          customcard("Đề 2",images[1]),
//          customcard("Đề 3",images[2]),
//          customcard("Đề 4",images[3]),
//          customcard("Đề 5",images[4]),

//    ],
      );

  }
}