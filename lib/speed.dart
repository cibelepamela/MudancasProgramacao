import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class Speed extends StatefulWidget{
  @override
  State<Speed> createState() {
    return SpeedState();
  }

}


class SpeedState extends State<Speed>{
  static SpeedState instance = SpeedState();

  var geolocator = Geolocator();
  Position lapLocation;
  
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
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //Condicional para aparecer a velocidade
                  lapLocation == null
                      ? CircularProgressIndicator()
                      : Text((3.6*lapLocation.speed).toStringAsFixed(1) + " Km/h",
                      style: TextStyle(fontSize: 100,
                        color:
                        Colors.black,)),
        ],
        ),
    );
  }

}