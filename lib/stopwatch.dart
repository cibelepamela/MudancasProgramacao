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
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: 
          AnimatedBuilder(
            animation: Chronometer.instance,
            builder: (BuildContext context, Widget child) { 
              return Text(
                      Chronometer.instance.display,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    );
          },)
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
            ],
            )
        )
      ],
    );
  }

}