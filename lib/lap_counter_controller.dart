import 'dart:async';
import 'home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';


class LapCounterController extends ChangeNotifier{

  static LapCounterController instance = LapCounterController();

  int lap = 0;
  final dur = const Duration(milliseconds: 1);
  bool flagLap = true;
  double distance1;
  Position startPosition;
  var now1;
  var time1;


  void start() async{
    flagLap = true;
    now1 = DateTime.now();
    startPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    volta();
  }


  void reset(){
    flagLap = false;
    lap = 0;
  }


  void atualizar_volta(){
    Timer(dur, volta);
  }


  void volta() async{
    distance1 = await Geolocator().distanceBetween(
      startPosition.latitude,
      startPosition.longitude,
      HomePageState.instance.lapLocation.latitude,
      HomePageState.instance.lapLocation.longitude
      );
    time1 = DateTime.now().difference(now1).inMilliseconds;
    //time2 = DateTime.now().difference(now2).inMilliseconds;
    if ( time1>1000 && distance1<5 && flagLap ){
      lap++;
      now1 = DateTime.now();
      notifyListeners();
    }
    atualizar_volta();
  }
}