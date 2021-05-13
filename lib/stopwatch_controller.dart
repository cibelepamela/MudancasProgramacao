import 'dart:async';

import 'home_page.dart';
import 'lap_counter_controller.dart';
import 'package:flutter/widgets.dart';
import 'lap_counter_controller.dart';
import 'package:uuid/uuid.dart';

class Chronometer extends ChangeNotifier{


  static Chronometer instance = Chronometer();


  bool startispressed = true;
  bool stopispressed = true;
  String display = '00:00:00';
  int tempo = 0;
  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 60);
  var round_uuid;
  var uuid = Uuid();


  //Executando keepruning depois de uma certa duração
  void starttimer(){
    Timer(dur, keepruning);
  }


  void keepruning(){
    if (swatch.isRunning) {
      starttimer();
    }
    //Atualiza a tela
    if (tempo <= 10000){
      display =
          swatch.elapsed.inMinutes.toString().padLeft(2, '0') + ':' +
            (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') + ':' +
              (swatch.elapsed.inMilliseconds % 60).toString().padLeft(2, '0');
      tempo = swatch.elapsed.inMilliseconds;
    } else {
      swatch.reset();
      tempo = 0;
    }

    notifyListeners();
  }


  //Botão de start
  startstopwatch(){
    swatch.start();
    starttimer();
    stopispressed = false;
    startispressed = false;
    LapCounterController.instance.start();
    round_uuid = uuid.v4();
    notifyListeners();
  }


  //Botão de pause
  stopstopwatch(){
      stopispressed = true;
      startispressed = true;
      display = '00:00:00';
      swatch.stop();
      swatch.reset();
      LapCounterController.instance.reset();
      notifyListeners();
  }
}