import 'dart:async';
import 'speed.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';


class LapCounterController extends ChangeNotifier{

  static LapCounterController instance = LapCounterController();


  final lap = ValueNotifier<int>(0);
  final dur = const Duration(milliseconds: 500);
  bool flagLap = true;
  double distance1;
  Position startPosition;
  var now1;
  var time1;


  void start() async{
    flagLap = true;
    SpeedState.instance.lapLocation = await SpeedState.instance.geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    startPosition = await SpeedState.instance.geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    now1 = DateTime.now();
    volta();
  }


  void reset(){
    flagLap = false;
    lap.value = 0;
  }


  void atualizar_volta(){
    Timer(dur, volta);
  }


  void volta() async{
    distance1 = await SpeedState.instance.geolocator.distanceBetween(
      startPosition.latitude,
      startPosition.longitude,
      SpeedState.instance.lapLocation.latitude,
      SpeedState.instance.lapLocation.longitude
      );
    time1 = DateTime.now().difference(now1).inMilliseconds;
    //time2 = DateTime.now().difference(now2).inMilliseconds;
    if (time1>5000 && flagLap ){
      lap.value++;
      now1 = DateTime.now();
      notifyListeners();
    }
    atualizar_volta();
  }
}