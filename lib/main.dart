import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light));
  runApp(TimerApp());
}

class TimerApp extends StatefulWidget {
  @override
  _TimerAppState createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void changeKey(){
    setState(() {
      isActive = !isActive;
    });
}

  void reset(){
    setState(() {
      secondsPassed = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.blue[40],
          appBar: AppBar(
            backgroundColor: Colors.blue[500],
            title: Row(
              children: <Widget>[
                Text('Clockify LITE '),
                Icon(Icons.timer)
              ],
            ),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LabelText(
                        label: 'HRS', value: hours.toString().padLeft(2, '0')),
                    LabelText(
                        label: 'MIN',
                        value: minutes.toString().padLeft(2, '0')),
                    LabelText(
                        label: 'SEC',
                        value: seconds.toString().padLeft(2, '0')),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  width: 200,
                  height: 120,
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        color: Colors.blue[500],
                        child: Text(isActive ? ' STOP ' : 'START', style: TextStyle(color: Colors.white, fontSize: 20)),
                        onPressed: () {
                          changeKey();
                        },
                      ),
                      OutlineButton(
                        color: Colors.pink[200],
                        child: Text('RESET', style: TextStyle(color: Colors.blue[500], fontSize: 20)),
                        onPressed: () {
                          reset();
                        },
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ));
  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue[500],
      ),
      child: Column(
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 55, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
