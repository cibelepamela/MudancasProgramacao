import 'package:flutter/material.dart';
import 'dart:async';
int tempo = 0;
int flag = 0;

class chronometer extends StatefulWidget {
  @override
  _chronometerState createState() => _chronometerState();
}

class _chronometerState extends State<chronometer> {
  bool startispressed = true;
  bool stoptispressed = true;
  bool resettispressed = true;
  String stoptimetodisplay = '00:00:00';
  int flag;

  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);

  void starttimer(){
    Timer(dur, keepruning);
  }

  void keepruning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      if (tempo <= 10000) {
        stoptimetodisplay =
            swatch.elapsed.inMinutes.toString().padLeft(2, '0') + ':' +
                (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
                ':' +
                (swatch.elapsed.inMilliseconds % 60).toString().padLeft(2, '0');
        tempo = swatch.elapsed.inMilliseconds;
      }
      else {
        swatch.reset();
        tempo = 0;
      }
    });
  }

  void startstopwatch(){
    setState(() {
      stoptispressed = false;
      startispressed = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch(){
    setState(() {
      stoptispressed = true;
      resettispressed = false;
    });
    swatch.stop();
  }

  void resetstopwatch(){
    setState(() {
      startispressed = true;
      resettispressed = true;
    });
    swatch.reset();
  }

  void flags(){
    if (tempo == 10000){
      flag = 1;
    }
    if (tempo == 5000){
      flag = 0;
    }
  }

  @override

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.center,
            child: Text(stoptimetodisplay,
            style: TextStyle(fontSize: 30.0,
            fontWeight: FontWeight.w700,
            color: Colors.white)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RaisedButton(
                  color: Colors.red,
                  child: Text(
                    'Stop',
                    style: TextStyle(fontSize: 10.0),
                  ),
                  onPressed: (){
                    stoptispressed ? null: stopstopwatch();
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  color: Colors.amber,
                  child: Text('Reset',
                  style: TextStyle(fontSize: 10.0),
                  ),
                  onPressed: (){
                    resettispressed ? null: resetstopwatch();
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: RaisedButton(
            color: Colors.green,
            child: Text('Start',
            style: TextStyle(fontSize: 15.0),
            ),
            onPressed: (){
              startispressed ? startstopwatch(): null;
            },
          ),
        )
      ],
    );
  }
}

class teste extends StatefulWidget {
  @override
  _testeState createState() => _testeState();
}

class _testeState extends State<teste> {
  @override
  Widget build(BuildContext context) {
    if (flag == 0){
      return Container(color: Colors.black,);
    }
    if (flag == 1){
      return Container(color: Colors.white);
    }
  }
}

