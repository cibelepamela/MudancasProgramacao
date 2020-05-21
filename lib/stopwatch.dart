import 'package:flutter/material.dart';
import 'dart:async';

class chronometer extends StatefulWidget {
  @override
  _chronometerState createState() => _chronometerState();
}

class _chronometerState extends State<chronometer> {
  bool startispressed = true;
  bool stoptispressed = true;
  bool resettispressed = true;
  String stoptimetodisplay = '00:00:00';
  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);

  void starttimer(){
    Timer(dur, keepruning);
  }

  void keepruning(){
    if(swatch.isRunning){
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inMinutes.toString().padLeft(2, '0') + ':' + (swatch.elapsed.inSeconds%60).toString().padLeft(2, '0') + ':' + (swatch.elapsed.inMilliseconds%60).toString().padLeft(2, '0');
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
            fontWeight: FontWeight.w700)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: FlatButton(
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
                child: FlatButton(
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
          child: FlatButton(
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
