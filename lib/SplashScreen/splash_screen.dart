import 'package:bker_sos/animations/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../HomePage.dart';

class SplashScreen extends StatefulWidget{
  @override
  _splashState createState() => _splashState();
}
class _splashState extends State<SplashScreen> with TickerProviderStateMixin{
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    Firestore.instance.collection('books').document()
//        .setData({ 'title': 'title', 'author': 'author' });
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 0.8
    ).animate(_scaleController)..addStatusListener((status){
      if (status == AnimationStatus.completed){
        _widthController.forward();
      }
    });
    _widthController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600)
    );
    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0
    ).animate(_widthController)..addStatusListener((status){
      if (status == AnimationStatus.completed){
        _positionController.forward();
      }
    });

    _positionController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
    );
    _positionAnimation = Tween<double>(
        begin: 0.0,
        end: 220.0
    ).animate(_positionController)..addStatusListener((status){
      if (status == AnimationStatus.completed){
        setState(() {
          hideIcon = true;
        });
        _scale2Controller.forward();
      }
    });

    _scale2Controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
    );
    _scale2Animation = Tween<double>(
        begin: 1.0,
        end: 2.0
    ).animate(_scale2Controller)
      ..addStatusListener((status){
      if (status == AnimationStatus.completed){
//        Navigator.push(context, PageTransition(type: PageTransitionType.rotate,child: HomePage()));
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage()
          ) );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -100.0,
              left: .0,
              child: FadeAnimation(1,Container(
                  width: width,
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/one.png'),
                        fit: BoxFit.cover,
                      )
                  )
              ),
            )
            ),
            Positioned(
              top: -150.0,
              left: .0,
              child: FadeAnimation(1,Container(
                  width: width,
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/one.png'),
                        fit: BoxFit.cover,
                      )
                  )
              ),
            )
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  FadeAnimation(1,Text(
                    "Hust Family",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:'Satisfy' ,
                      fontSize: 60.0
                    ),
                  )),
                  SizedBox(height: 30.0,),
                  FadeAnimation(1.3, Text(
                    "ứng dụng hỗ trợ các bạn tân sinh viên",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  )),
                  SizedBox(height: 200.0,),
                  FadeAnimation(1.6,AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) => Container(
                              padding: EdgeInsets.all(10.0),
                              width: _widthAnimation.value,
                              height: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(165, 42, 42, .4),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100.0),
                                onTap: (){
                                  _scaleController.forward();
                                },
                                  child: Stack(
                                    children: <Widget>[
                                      AnimatedBuilder(
                                        animation: _positionController,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller,
                                            builder: (context, child) => Transform.scale(
                                              scale: _scale2Animation.value,
                                              child: Container(
                                                width: 60.0,
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                  color: Color.fromRGBO(165, 42, 42, 1),
                                                  shape: BoxShape.circle,
                                                ),
                                                  child: SpinKitRipple(
                                                    color: Colors.lightBlue,
                                                    size: 200.0,
                                                  )
                                          )),
                                        ),
                                      ),
                                      )],

                                  ),
                              ),
                            ),
                          ),
                        ),
                    ),
                  )),
                  SizedBox(height: 30.0,)

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}