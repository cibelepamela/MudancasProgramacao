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
          child: Expanded(
            flex: 1,
            child: chronometer(),
          ),
      ),
    );
  }
}