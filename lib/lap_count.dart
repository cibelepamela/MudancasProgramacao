
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'lap_counter_controller.dart';

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
      child: 
      AnimatedBuilder(
        animation: LapCounterController.instance,
        builder: (context, child){
          return Text(
            LapCounterController.instance.lap.toString() + " laps",
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