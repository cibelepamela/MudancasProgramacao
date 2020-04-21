import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './home_page.dart';


Future main() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( 
          primarySwatch: Colors.yellow,
        ),
      home: HomePage(),
    );
  }
}
