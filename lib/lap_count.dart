
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'lap_counter_controller.dart';
import 'speed.dart';

class LapCounter extends StatefulWidget{
  @override
  State<LapCounter> createState() {
    return LapConterState();
  }

}

class LapConterState extends State<LapCounter>{

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: LapCounterController.instance.lap,
        builder: (context, value, child){
          return Text(
            LapCounterController.instance.lap.value.toString() + "laps",
            style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          );
        },
      )
    );
  }
}