import 'stopwatch.dart';
import 'speed.dart';
import 'lap_count.dart';
import 'stopwatch.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() {
    return HomePageState();
  }

}


class HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.yellow[300],
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Speed()
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
                      )
                    ],
                  )
                )
            ],
          ),
        ),
      )
    );
  }

}