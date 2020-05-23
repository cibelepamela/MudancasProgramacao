import 'package:fenrir_software/lap_counter.dart';
import 'package:flutter/material.dart';
import 'stopwatch.dart';
import './location_manager.dart';

class HomePage extends StatelessWidget {
  var userLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text("Equipe Fenrir"),
      //),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2, // 20%
              child: Container(color: Colors.black),
            ),
            Expanded(
              flex: 6, // 60%
              child: Container(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: locationManager(),
                    ),
                    Expanded(
                      flex:1,
                      child:chronometer(),
                    )
                  ]
                )
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Colors.yellow[100],
                      child: LapCounter(),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/fenrir.png"),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.yellow[300],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


