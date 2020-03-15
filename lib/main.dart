import 'package:bker_sos/SplashScreen/splash_screen.dart';
import 'package:bker_sos/animations/FadeAnimation.dart';
import 'package:flutter/material.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<Main> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BK",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SplashScreen(),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
