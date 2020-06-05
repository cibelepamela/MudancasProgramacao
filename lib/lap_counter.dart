import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class LapCounter extends StatefulWidget {
  @override
  LapCounterState createState() => LapCounterState();
}

class LapCounterState extends State<LapCounter> {
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
      "set": set.toString()
    });
    var response = await http.post('http://fenrir.servebeer.com:1996/FenrirApi', body: json, headers: {'Content-Type': 'application/json'});
    print('Response status: ${response.statusCode}');
  }

  void volta() async{
    distance1 = await geolocator.distanceBetween(startPosition1.latitude, startPosition1.longitude, lapLocation.latitude, lapLocation.longitude);
    time1 = DateTime.now().difference(now1).inSeconds;
    if (distance1 < 10 && time1 > 2){
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
    time2 = DateTime.now().difference(now2).inSeconds;
    if (distance2 < 10 && time2 > 2){
      set++;
      now2 = DateTime.now();
    }
    if (distance3 < 10 && time2 > 2){
      set++;
      now2 = DateTime.now();
    }
    if (distance3 < 10 && time2 > 2){
      set++;
      now2 = DateTime.now();
    }
    if (set > 4){
      set = 1;
    }
  }


  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(
            alignment: Alignment.center,
            child:
            lapLocation == null
                ? CircularProgressIndicator()
                : Text(lap.toString() + " laps",
                style: TextStyle(fontSize: 30.0)),
          )
        ),
        Expanded(
          flex: 4,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async{
                    var asinc = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
                    setState(() {
                      startPosition1 = asinc;
                      round_uuid = uuid.v4();
                      now1 = DateTime.now();
                      now2 = DateTime.now();
                    });
                  },
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 15.0,
                  ),
                  child: Text('Start',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),),
                ),
                RaisedButton(
                  onPressed: (){
                    setState(() {
                      startPosition1 = null;
                      lap = 0;
                    });
                  },
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 80.0,
                    vertical: 15.0,
                  ),
                  child: Text('Stop',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
/* _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentSpeed = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}*/

