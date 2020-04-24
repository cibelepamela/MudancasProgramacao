import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

class locationManager extends StatefulWidget {
  @override
  _locationManagerState createState() => _locationManagerState();
}

class _locationManagerState extends State<locationManager> {
  Geolocator geolocator = Geolocator();

  Position userLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geolocator
        .getPositionStream(
            LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 200))
        .listen((position) {
      setState(() {
        userLocation = position;
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        userLocation == null
            ? CircularProgressIndicator()
            : Text((3.6*userLocation.speed).toStringAsFixed(1) + " km/h",
                style: TextStyle(fontSize: 100)),
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
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
