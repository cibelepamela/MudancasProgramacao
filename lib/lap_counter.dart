import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class LapCounter extends StatefulWidget {
  @override
  LapCounterState createState() => LapCounterState();
}

class LapCounterState extends State<LapCounter> {
  var geolocator = Geolocator();
  Position lapLocation;
  Position startPosition;
  int lap = 0;
  double distance;
  var time;
  var now;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    geolocator
        .getPositionStream(
        LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 200))
        .listen((lapPosition) {
      setState(() {
        lapLocation = lapPosition;
      });
    });
  }

  void volta() async{
    distance = await geolocator.distanceBetween(startPosition.latitude, startPosition.longitude, lapLocation.latitude, lapLocation.longitude);
    time = DateTime.now().difference(now).inSeconds;
    if (distance < 3 && time > 20){
      lap++;
      now = DateTime.now();
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
                color: Colors.white,
                child: Text(
                  lap.toString() + "laps",
                  style: TextStyle(fontSize: 50),
                ),
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
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  onPressed: (){
                    setState(() async{
                      startPosition = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
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
                    "Zerar",
                    style: TextStyle(fontSize: 50, color: Colors.black),
                  ),
                  onPressed: (){
                    setState(() {
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

