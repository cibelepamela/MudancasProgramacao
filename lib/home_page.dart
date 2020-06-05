import 'package:flutter/material.dart';
import 'lap_counter.dart';
import 'stopwatch.dart';
import 'location_manager.dart';

class HomePage extends StatelessWidget {
  var userLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text("Equipe Fenrir"),
      //),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2, // 20%
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Colors.black,
                      child: locationManager(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.yellow[100],
                      child: LapCounter(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/fenrir.png"),
                          fit: BoxFit.fill,
                        ),
                        color: Colors.yellow[300],
                      ),
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              flex: 1,
              child: chronometer()
              ),
          ])
      ),
    );
  }
}


