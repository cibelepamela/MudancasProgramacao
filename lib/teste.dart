import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class chronometer extends StatefulWidget {
  @override
  _chronometerState createState() => _chronometerState();
}

class _chronometerState extends State<chronometer> {
  var geolocator = Geolocator();
  var uuid = Uuid();
  Position lapLocation;
  Position startPosition1, startPosition2, startPosition3, startPosition4;
  int lap = 0, set = 0;
  double distance1, distance2, distance3, distance4;
  var time1, time2;
  var now1, now2;
  var round_uuid;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    geolocator
        .getPositionStream(
        LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 500))
        .listen((position) {
      setState(() {
        lapLocation = position;
        if (startPosition1 != null){
          volta();
          post();
          setor();
        }
      });
    });
  }

  Future<Void> post() async{
    String json = jsonEncode(<String, String>{
      "lap": lap.toString(),
      "lat": lapLocation.latitude.toString(),
      "lon": lapLocation.longitude.toString(),
      "round_uuid": round_uuid,
      "vel": (3.6*lapLocation.speed).toStringAsFixed(2),
      "set": set.toString(),
      "time set": time2.toString(),
    });
    var response = await http.post('http://fenrir.servebeer.com:1996/FenrirApi', body: json, headers: {'Content-Type': 'application/json'});
    print('Response status: ${response.statusCode}');
  }

  void volta() async{
    distance1 = await geolocator.distanceBetween(startPosition1.latitude, startPosition1.longitude, lapLocation.latitude, lapLocation.longitude);
    time1 = DateTime.now().difference(now1).inMilliseconds;
    if (distance1 < 10 && time1 > 2000){
      lap++;
      set++;
      now1 = DateTime.now();
      now2 = DateTime.now();
//      print(distance);
    }
  }

  void setor() async{
    distance2 = await geolocator.distanceBetween(startPosition2.latitude, startPosition2.longitude, lapLocation.latitude, lapLocation.longitude);
    distance3 = await geolocator.distanceBetween(startPosition3.latitude, startPosition3.longitude, lapLocation.latitude, lapLocation.longitude);
    distance4 = await geolocator.distanceBetween(startPosition4.latitude, startPosition4.longitude, lapLocation.latitude, lapLocation.longitude);
    time2 = DateTime.now().difference(now2).inMilliseconds;
    if (distance2 < 10 && time2 > 2000){
      set++;
      now2 = DateTime.now();
    }
    if (distance3 < 10 && time2 > 2000){
      set++;
      now2 = DateTime.now();
    }
    if (distance3 < 10 && time2 > 2000){
      set++;
      now2 = DateTime.now();
    }
    if (set > 4){
      set = 1;
    }
  }






  bool startispressed = true;
  bool stopispressed = true;
  String stoptimetodisplay = '00:00:00';
  var swatch = Stopwatch();
  var swa = new Stopwatch();
  final dur = const Duration(milliseconds: 1);
  int tempo = 0;
  int tempo1 = 0;
  int tempo2 = 0;
  double velocidade;
  int timeSetor;
  int i = 1;


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

  void startstopwatch() async{
    var asinc = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    swatch.start();
    swa.start();
    starttimer();
    setState(() {
      startPosition1 = asinc;
      round_uuid = uuid.v4();
      now1 = DateTime.now();
      now2 = DateTime.now();
      stopispressed = false;
      startispressed = false;
    });
  }

  void stopstopwatch(){
    setState(() {
      startPosition1 = null;
      lap = 0;
      stopispressed = true;
      startispressed = true;
      stoptimetodisplay = '00:00:00';
    });
    swatch.stop();
    swatch.reset();
    swa.stop();
    swa.reset();
  }

  void startstopwatch_vel() async{
    velocidade = lapLocation.speed*3.6;
    if(velocidade > 5){
      var asinc = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      swatch.start();
      starttimer();
      setState(() {
        startPosition1 = asinc;
        round_uuid = uuid.v4();
        now1 = DateTime.now();
        now2 = DateTime.now();
        stopispressed = false;
        startispressed = false;
      });
    }
  }



  @override

  Widget build(BuildContext context) {
    return Container(
        color:
        tempo >=5000
            ? Colors.white
            : Colors.yellow[300],
        decoration: BoxDecoration(
            image: DecorationImage(
                image:  AssetImage("assets/images/fenrir.png"),
                fit: BoxFit.cover
            )
        ),
        child:
        Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  lapLocation == null
                      ? CircularProgressIndicator()
                      : Text((3.6*lapLocation.speed).toStringAsFixed(1) + " km/h",
                      style: TextStyle(fontSize: 100,
                        color:
                        Colors.black,)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        stoptimetodisplay + '\n' + tempo1.toString(),
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      child:
                      lapLocation == null
                          ? CircularProgressIndicator()
                          : Text(
                          lap.toString() + " laps",
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w700,
                            color:
                                Colors.black,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        child:
                        FlatButton(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.green,
                          ),
                          onPressed:
                          startispressed
                              ? startstopwatch
                              : null,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 2.0,
                          ),
                        ),
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child:
                        FlatButton(
                          child: Icon(
                            Icons.stop,
                            color: Colors.red,
                          ),
                          onPressed:
                          stopispressed
                              ? null
                              : stopstopwatch,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 2.0,
                          ),
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}