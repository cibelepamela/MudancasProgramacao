import 'package:flutter/material.dart';
import 'stopwatch.dart';
import 'dart:async';

class luz extends StatefulWidget {
  @override
  _luzState createState() => _luzState();
}

class _luzState extends State<luz> {
  time tempo = new time();
  tempo.getTempo();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
