import 'dart:async';
import 'dart:convert';
import 'package:bker_sos/View/resultquiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class getjson extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/python.json"),
      builder: (context, snapshot){
        List mydata = jsonDecode(snapshot.data.toString());
        if (mydata == null){
          return Scaffold(
            body: Center(
              child: Text(
                "Loading..."
              ),
            ),
          );
        }else{
          return quizzpage(mydata : mydata);
        }
      },
    );
  }
}
class quizzpage extends StatefulWidget{
  var mydata;
  quizzpage({Key key, @required this.mydata}):super(key : key);

  @override
  _quizpagestate createState() => _quizpagestate(mydata);
}
class _quizpagestate extends State<quizzpage>{
  var mydata;
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int mark = 0;
  int i = 1;
  int timer = 15;
  String showtimer = "15";
  Map<String, Color> btncolor = {
    "a" :  Color.fromRGBO(165, 42, 42, 0.8),
    "b" :  Color.fromRGBO(165, 42, 42, 0.8),
    "c" :  Color.fromRGBO(165, 42, 42, 0.8),
    "d" :  Color.fromRGBO(165, 42, 42, 0.8)
  };
  bool cancelTimer = false;

  @override
  void initState(){
    StartTimer();
    super.initState();
  }

  void StartTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t){
      setState(() {
        if(timer < 1 ){
          t.cancel();
          nextquestion();
        }else if(cancelTimer == true){
          t.cancel();
        }
        else{
          timer -= 1;
        }
        showtimer = timer.toString();
      });
    });

  }
  void nextquestion(){
    cancelTimer = false;
    timer = 15;
    setState(() {
      if(i < 5){
        i++;
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks : mark),
        ));
      }
      btncolor["a"] =  Color.fromRGBO(165, 42, 42, 0.8);
      btncolor["b"] =  Color.fromRGBO(165, 42, 42, 0.8);
      btncolor["c"] =  Color.fromRGBO(165, 42, 42, 0.8);
      btncolor["d"] =  Color.fromRGBO(165, 42, 42, 0.8);
    });
    StartTimer();
  }
  void checkanswer(String k){
    if(mydata[2]["1"].toString() == mydata[1]["1"][k]){
      mark += 5;
      colortoshow = right;
    }else{
      colortoshow = wrong;
    }
    setState(() {
      btncolor[k] = colortoshow;
      cancelTimer = true;
    });
    Timer(Duration(seconds: 1), nextquestion);
  }

  _quizpagestate(this.mydata);
  Widget choicebutton(String k){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Alike',
            fontSize: 16.0 ,
          ),
          maxLines: 1,
        ),
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: btncolor[k],
        splashColor:  Color.fromRGBO(165, 42, 42, 1),
        highlightColor:  Color.fromRGBO(165, 42, 42, 1)

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: (){
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
              "QuizStar",
            ),
              content: Text(
                "Ban khong the quay lai"
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                )
              ],
          )
        );
      },
        child: Scaffold(
          backgroundColor: Color.fromRGBO(165, 42, 42, 0.8),
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    mydata[0][i.toString()],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Quando',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    choicebutton('a'),
                    choicebutton('b'),
                    choicebutton('c'),
                    choicebutton('d'),
                  ],
                ),
              ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    showtimer,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        );
  }
}