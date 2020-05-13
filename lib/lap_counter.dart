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
  Position startPosition;
  int lap = 0;
  double distance;
  var time;
  var now;
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
        if (startPosition != null){
          volta();
          post();
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
      "vel": (3.6*lapLocation.speed).toStringAsFixed(2)
    });
    var response = await http.post('http://fenrir.servebeer.com:1996/FenrirApi', body: json, headers: {'Content-Type': 'application/json'});
    print('Response status: ${response.statusCode}');
  }

  void volta() async{
    distance = await geolocator.distanceBetween(startPosition.latitude, startPosition.longitude, lapLocation.latitude, lapLocation.longitude);
    time = DateTime.now().difference(now).inSeconds;
    if (distance < 10 && time > 2){
      lap++;
      now = DateTime.now();
//      print(distance);
    }
  }


  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Container(
                child:
                lapLocation == null
                    ? CircularProgressIndicator()
                    : Text(lap.toString() + " laps",
                  style: TextStyle(fontSize: 30)),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: FlatButton(
                  color: Colors.black,
                  child: Text(
                    "start",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  onPressed: ()async{
                    var asinc = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
                    setState(() {
                      startPosition = asinc;
                      round_uuid = uuid.v4();
                      now = DateTime.now();
                    });
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: FlatButton(
                  color: Colors.white,
                  child: Text(
                    "Stop",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  onPressed: (){
                    setState(() {
                      startPosition = null;
                      lap = 0;
                    });
                  },
                )
              )
            ],
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

