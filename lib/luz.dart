import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
    setState(() {
        if (getTempo() == 10000)
          return Container(color: Colors.white);
        if (getTempo() == 5000)
          return Container(color: Colors.black);
    });
  }
}