import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class chronometer extends StatefulWidget {
  @override
  _chronometerState createState() => _chronometerState();
}

class _chronometerState extends State<chronometer> {
  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = '00:00:00';
  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);
  int tempo = 0;
  int flag = 0;

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
      stopispressed = false;
      startispressed = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch(){
    setState(() {
      stopispressed = true;
      resetispressed = false;
    });
    swatch.stop();
  }

  void resetstopwatch(){
    setState(() {
      startispressed = true;
      resetispressed = true;
      stoptimetodisplay = '00:00:00';
    });
    swatch.reset();
  }

  int flags(){
    setState(() {
      if (tempo == 10000){
        flag = 1;
      }
      if (tempo == 5000){
        flag = 0;
      }
    });
  }

  @override

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 6,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        stoptimetodisplay,
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                onPressed:
                                stopispressed
                                    ? null
                                    : stopstopwatch,
                                color: Colors.red,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.0,
                                  vertical: 10.0,
                                ),
                                child: Text(
                                  'Stop',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              RaisedButton(
                                onPressed:
                                resetispressed
                                    ? null
                                    : resetstopwatch,
                                color: Colors.teal,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 40.0,
                                  vertical: 10.0,
                                ),
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          RaisedButton(
                            onPressed:
                            startispressed
                                ? startstopwatch
                                : null,
                            color: Colors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: 80.00,
                              vertical: 25.00,
                            ),
                            child: Text(
                              'Start',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
        Expanded(
          flex: 4,
          child:
          flag == 0
              ?Container(color: Colors.black)
              :Container(color: Colors.white),
        )
      ],
    );
  }
}
