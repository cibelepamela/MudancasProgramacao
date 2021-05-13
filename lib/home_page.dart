import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:fenrir_software/stopwatch_controller.dart';
import 'package:geolocator/geolocator.dart';

import 'lap_counter_controller.dart';
import 'stopwatch.dart';
import 'lap_count.dart';
import 'stopwatch.dart';

import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() {
    return HomePageState();
  }

}


class HomePageState extends State<HomePage> {

  static HomePageState instance = HomePageState();


  Position lapLocation;
  StreamSubscription<Position> positionStream;


  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 500);
    positionStream =  Geolocator().getPositionStream(locationOptions).listen((Position position) {
      setState(() {
        lapLocation = position;
      });
      HomePageState.instance.lapLocation = position;
    });
  }


  
  //Faz o post na API
  Future<Void> post() async{
    String json = jsonEncode(<String, String> {
      "lap": LapCounterController.instance.lap.value.toString(),
      "lat": lapLocation.latitude.toString(),
      "lon": lapLocation.longitude.toString(),
      "round_uuid": Chronometer.instance.round_uuid,
      "vel": (3.6*lapLocation.speed).toStringAsFixed(2),
      "timelap": LapCounterController.instance.time1.toString(),
    });
    var response = await http.post('http://35.194.6.143/FenrirApi', body: json, headers: {'Content-Type': 'application/json'});
    print('Response status: ${response.statusCode}');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color:
          Chronometer.instance.tempo >= 5000
            ? Colors.white
            : Colors.yellow[300],
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    lapLocation == null
                      ? CircularProgressIndicator()
                      :Text((lapLocation.speed*3.6).toStringAsFixed(2) + " Km/h",
                        style: TextStyle(fontSize: 100,
                          color:
                          Colors.black,)),
                  ],
                )
              ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ChronometerDisplay()
                      ),
                      Expanded(
                        flex: 1,
                        child: LapCounter()
                      ),
                    ],
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                flex: 1,
                child: Container(
                  child: 
                    AnimatedBuilder(
                      animation: Chronometer.instance,
                      builder: (context, child) { 
                        return 
                        FlatButton(
                          height: 70,
                          onPressed:
                            //Condicional para ver se o botão está ativo
                            Chronometer.instance.startispressed
                              ? Chronometer.instance.startstopwatch 
                              : null,
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.green,
                            ),
                        );      
                      },
                    )  
          ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: 
                  AnimatedBuilder(
                    animation: Chronometer.instance,
                    builder: (context, child) {
                      return FlatButton(
                        height: 70,
                        onPressed:
                          //Condicional para ver se o botão está ativo
                          Chronometer.instance.stopispressed
                            ? null
                            : Chronometer.instance.stopstopwatch,
                        child: Icon(
                          Icons.stop,
                          color: Colors.red,
                        ),
                      );
                      },)
          ),
              )
                  ],)
                )
            ],
          ),
        ),
      )
    );
  }

}