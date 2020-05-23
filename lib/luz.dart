import 'package:flutter/material.dart';
import 'stopwatch.dart';
import 'dart:async';

class luz extends StatefulWidget {
  @override
  _luzState createState() => _luzState();
}

class _luzState extends State<luz> with timeFlag{
  int getTempo() {
    // TODO: implement getTempo
    return super.getTempo();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:
      getTempo() == 0 
            ?  Colors.black  //muda fundo para preto se tempo = 0
            :  Colors.white, //muda fundo para branco se tempo = 1
    );
  }
}