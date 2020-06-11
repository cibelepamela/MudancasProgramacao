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
                      ],
                    )
                ),
                Expanded(
                    flex: 2,
                    child: chronometer()
                ),
              ])
      ),
    );
  }
}
