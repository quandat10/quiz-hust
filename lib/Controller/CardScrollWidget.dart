import 'dart:math';
import 'dart:typed_data';

import 'package:bker_sos/SubHomePage/BKMap.dart';
import 'package:bker_sos/View/loadingpage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dataBKMap.dart';

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
//                      Image.asset("images/bad.png"),

                      ImageFirebase(i),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 50.0),
                          ),
                          Text(title[images.length - 1 - i],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: "Alike-Regular")),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "assets/company.svg",
                                        height: 20.0,
                                        width: 20.0,
                                      ),
                                      Text(
                                        " Văn phòng : ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        (local[images.length - 1 - i])
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SvgPicture.asset("assets/call.svg",
                                          color: Colors.green,
                                          height: 20.0,
                                          width: 20.0),
                                      Text(
                                        " Điện thoại : ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        (phone[images.length - 1 - i])
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SvgPicture.asset("assets/contact.svg",
                                          color: Colors.blueAccent,
                                          height: 20.0,
                                          width: 20.0),
                                      Text(
                                        " Website : ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        (website[images.length - 1 - i])
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SvgPicture.asset("assets/mail.svg",
                                          height: 20.0, width: 20.0),
                                      Text(
                                        " Email : ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        (email[images.length - 1 - i])
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(165, 42, 42, 0.8),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text("Xem chi tiết",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}

class ImageFirebase extends StatefulWidget {
  int _idx;

  ImageFirebase(int index) {
    this._idx = index;
  }

  @override
  _ImageFirebaseState createState() => _ImageFirebaseState();
}

class _ImageFirebaseState extends State<ImageFirebase> {
  Uint8List imageFile;
  int MAX_SIZE = 3 * 1024 * 1024;
  StorageReference map = FirebaseStorage.instance.ref().child("BKImages");

  getImage() {
    map.child("bk${widget._idx}.jpg").getData(MAX_SIZE).then((data) {
      setState(() {
        imageFile = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  Widget loadImage() {
    if (imageFile == null) {
      return LoadingPage();
    } else {
      return Image.memory(
        imageFile,
        fit: BoxFit.fitHeight,
        colorBlendMode: BlendMode.darken,
        color: Colors.black45,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return loadImage();
  }
}
