import 'package:bker_sos/SubHomePage/BKBus.dart';
import 'package:bker_sos/SubHomePage/BKMap.dart';
import 'package:bker_sos/SubHomePage/BKService.dart';
import 'package:bker_sos/SubHomePage/BKTimeLine.dart';
import 'package:bker_sos/SubHomePage/FirstTest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
class GridDashBoard extends StatelessWidget{
  Items item1 = new Items("BK Map", "Bản đồ bách khoa", "Khoa, viện", "assets/map.svg", BKMap(),1);
  Items item2 = new Items("Khung thời gian", "March, Wednesday", "3 events", "assets/timeline.svg", BKTimeline(),0);
  Items item3 = new Items("BK Tiện ích", "March, Wednesday", "3 events", "assets/bus.svg", BKBus(),0);
  Items item4 = new Items("BK hỏi đáp", "March, Wednesday", "3 events", "assets/telemarketing.svg", BKService(),0);
  Items item5 = new Items("Kiểm tra quy chế", "1 đề 40 ", "5 đề", "assets/exam.svg", FirstTest(),1);
  Items item6 = new Items("Calendar", "March, Wednesday", "3 events", "images/notification.png", BKBus(),0);

  @override
  Widget build(BuildContext context) {

    List<Object> myfuction =  [BKMap(), BKTimeline(), BKBus(), BKService(), FirstTest()];
    List<Items> mylist = [item1,item2,item3, item4,item5,item6];

    var color = Colors.redAccent;
    // TODO: implement build
    return Flexible(

        child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: mylist.map((data){
            return GestureDetector(
              onTap: (){
                if (data.status == 1){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => data.object));

                }
                else{
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      child: new CupertinoAlertDialog(
                        title: new Column(
                          children: <Widget>[
                            new Text("Tính năng chưa hoàn thiện"),
                          ],
                        ),
                        actions: <Widget>[
                          new FlatButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: new Text(("Ok"),style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20.0
                          ),))
                        ],
                      )
                  );
                }

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 64, 64, .4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(data.img,width: 42,),
                    SizedBox(height: 14.0,),
                    Text(data.title, style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600
                      )
                    ),),
                    SizedBox(height: 8.0,),
                    Text(data.subtitle, style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600
                        )
                    ),),
                    SizedBox(height: 14.0,),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600
                        )
                    ),),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
    );
  }
}
class Items{
  String title;
  String subtitle;
  String event;
  String img;
  Object object;
  int status;
  Items(this.title, this.subtitle, this.event, this.img, this.object, this.status);


}