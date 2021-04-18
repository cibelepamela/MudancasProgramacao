import 'package:flutter/material.dart';
import 'stopwatch.dart';

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
                    flex: 2,
                    child: chronometer()
                ),
              ])
      ),
    );
  }
}