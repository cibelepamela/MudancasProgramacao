import 'package:flutter/material.dart';

import './location_manager.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text("Equipe Fenrir"),
      //),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2, // 20%
              child: Container(color: Colors.red),
            ),
            Expanded(
              flex: 6, // 60%
              child: Container(
                child: locationManager(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: Colors.yellow[100],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('0', style: TextStyle(fontSize: 50)),
                          Text(' Voltas', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/fenrir.png"),
                            fit: BoxFit.fill,
                          ),
                          color: Colors.yellow[300],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
