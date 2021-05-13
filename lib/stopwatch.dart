import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'stopwatch_controller.dart';


class ChronometerDisplay extends StatefulWidget{
  @override
  State<ChronometerDisplay> createState() {
    return ChronometerDisplayState();
  }

}


class ChronometerDisplayState extends State<ChronometerDisplay>{

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: Chronometer.instance,
        builder: (context, child){
          return Text(
            Chronometer.instance.display,
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