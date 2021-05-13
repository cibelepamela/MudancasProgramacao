import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './home_page.dart';

//void main() => runApp(MyApp());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
    .then((_) {
      runApp(new MyApp());
    });
}


class MyApp extends StatelessWidget {

  
  Widget build(BuildContext context) {
    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),

      //Importanto a classe HomePage
      home: HomePage(),

    );
  }
}