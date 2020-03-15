import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BKBus extends StatefulWidget{
  @override
  _BKBusState createState() => _BKBusState();
}
class _BKBusState extends State<BKBus>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.green,

      body: Center(
      child: SpinKitPulse(color: Colors.blue, size: 200.0,),
    ),
    );
  }
}