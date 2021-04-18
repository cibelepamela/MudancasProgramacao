import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class chronometer extends StatefulWidget {
  @override
  _chronometerState createState() => _chronometerState();
}

class _chronometerState extends State<chronometer> {

  //Criando variáveis
  var geolocator = Geolocator();
  var uuid = Uuid();
  Position lapLocation;
  Position startPosition1, startPosition2, startPosition3, startPosition4;
  int lap = 0, set = 0;
  double distance1, distance2, distance3, distance4;
  var time1, time2;
  var now1, now2;
  var round_uuid;
  bool flag = true;



  //Classe initState atualiza a tela quando muda algum valor
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geolocator
        .getPositionStream(
        LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 500))
        .listen((position) {
      setState(() {
        lapLocation = position;
        if (startPosition1 != null){
          volta();
          setor();
          post();
        }
      });
    });
  }


  //Faz o post na API
  Future<Void> post() async{
    String json = jsonEncode(<String, String> {
      "lap": lap.toString(),
      "lat": lapLocation.latitude.toString(),
      "lon": lapLocation.longitude.toString(),
      "round_uuid": round_uuid,
      "vel": (3.6*lapLocation.speed).toStringAsFixed(2),
      "set": set.toString(),
      "timelap": time1.toString(),
      "timeset": time2.toString(),
    });
    var response = await http.post('http://35.194.6.143/FenrirApi', body: json, headers: {'Content-Type': 'application/json'});
    print('Response status: ${response.statusCode}');
  }



  //Calcula em qual volta está
  void volta() async{
    distance1 = await geolocator.distanceBetween(startPosition1.latitude, startPosition1.longitude, lapLocation.latitude, lapLocation.longitude);
    time1 = DateTime.now().difference(now1).inMilliseconds;
    //time2 = DateTime.now().difference(now2).inMilliseconds;
    if (distance1 < 10 && time1 > 2000){
      lap++;
      set++;
      now1 = DateTime.now();
      now2 = DateTime.now();
      //print(distance);
    }
  }



  //Mostra em qual setor o carro está
  void setor() async{
    distance2 = await geolocator.distanceBetween(startPosition2.latitude, startPosition2.longitude, lapLocation.latitude, lapLocation.longitude);
    distance3 = await geolocator.distanceBetween(startPosition3.latitude, startPosition3.longitude, lapLocation.latitude, lapLocation.longitude);
    distance4 = await geolocator.distanceBetween(startPosition4.latitude, startPosition4.longitude, lapLocation.latitude, lapLocation.longitude);
    time2 = DateTime.now().difference(now2).inMilliseconds;
    if (distance2 < 10 && time2 > 2000){
      set++;
      now2 = DateTime.now();
    }
    if (distance3 < 10 && time2 > 2000){
      set++;
      now2 = DateTime.now();
    }
    if (distance3 < 10 && time2 > 2000){
      set++;
      now2 = DateTime.now();
    }
    if (set > 4){
      set = 1;
    }
  }




  //Variáveis do cronemetro
  bool startispressed = true;
  bool stopispressed = true;
  String stoptimetodisplay = '00:00:00';
  var swatch = Stopwatch();
  final dur = const Duration(milliseconds: 1);
  int tempo = 0;
  int tempo1 = 0;
  int tempo2 = 0;
  double velocidade;
  int timeSetor;
  int i = 1;


  
  //Cronometro
  
  //Executando keepruning depois de uma certa duração
  void starttimer(){
    Timer(dur, keepruning);
  }

  void keepruning() {
    if (swatch.isRunning) {
      starttimer();
    }

    //Atualiza a tela
    setState(() {
      if (tempo <= 10000) {
        stoptimetodisplay =
            swatch.elapsed.inMinutes.toString().padLeft(2, '0') + ':' +
                (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
                ':' +
                (swatch.elapsed.inMilliseconds % 60).toString().padLeft(2, '0');
        tempo = swatch.elapsed.inMilliseconds;
      }

      //Resetando o cronometro
      else {
        swatch.reset();
        tempo = 0;
      }
    });
  }



  //Botão de start
  void startstopwatch() async{
    //Definindo as posiçĩoes iniciais de cada setor
    var asinc1 = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    var asinc2 = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    var asinc3 = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    var asinc4 = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    swatch.start();
    starttimer();
    setState(() {
      startPosition1 = asinc1;
      startPosition2 = asinc2;
      startPosition3 = asinc3;
      startPosition4 = asinc4;
      round_uuid = uuid.v4();
      now1 = DateTime.now();
      now2 = DateTime.now();
      stopispressed = false;
      startispressed = false;
    });
  }


  //Botão de pause
  void stopstopwatch(){
    setState(() {
      startPosition1 = null;
      lap = 0;
      time1 = 0;
      time2 = 0;
      stopispressed = true;
      startispressed = true;
      stoptimetodisplay = '00:00:00';
      flag = true;
    });
    swatch.stop();
    swatch.reset();
  }


  //Start o cornometro altomaticamente com a velocidade
  void startstopwatch_vel() async{
    velocidade =  lapLocation.speed*3.6;
    if(velocidade > 5 && flag == true){
      startstopwatch();
      flag = false;
    }
  }
  @override

  Widget build(BuildContext context) {
    startstopwatch_vel();
    return Container(

      //Condicional para a cor de fundo
        color:
        tempo >=5000
            ? Colors.white
            : Colors.yellow[300],

        child:
        Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, //Centralizando
                children: <Widget>[

                  //Condicional para aparecer a velocidade
                  lapLocation == null
                      ? CircularProgressIndicator()
                      : Text((3.6*lapLocation.speed).toStringAsFixed(1) + " km/h",
                      style: TextStyle(fontSize: 100,
                        color:
                        Colors.black,)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(

                        //Display do cronometro
                        stoptimetodisplay,
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      child:

                      //Condicional para a volta
                      lapLocation == null
                          ? CircularProgressIndicator()
                          : Text(
                          lap.toString() + " laps",
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w700,
                            color:
                            Colors.black,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                        child:

                        //Botão de play
                        FlatButton(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.green,
                          ),
                          onPressed:

                          //Condicional para ver se o botão está ativo
                          startispressed
                              ? startstopwatch
                              : null,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 2.0,
                          ),
                        ),
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child:

                        //Botão de stop
                        FlatButton(
                          child: Icon(
                            Icons.stop,
                            color: Colors.red,
                          ),
                          onPressed:

                          //Condicional para ver se o botão está ativo
                          stopispressed
                              ? null
                              : stopstopwatch,
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 2.0,
                          ),
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
