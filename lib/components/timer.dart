import 'dart:async';

import 'package:flutter/material.dart';

class MyTimer extends StatefulWidget {
  @override
  _MyTimerState createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  bool _isStart = true;
  String _stopwatchText = '05:00';
  final _stopWatch = new Stopwatch();
  final _timeout = const Duration(seconds: 1);


  @override
  void deactivate() {
    super.deactivate();
    if(_stopwatchText == "05:00" || _stopwatchText == "05:00" ){
      _resetButtonPressed();
      _startStopButtonPressed();
    }
  }

  void _startTimeout() {
    new Timer(_timeout, _handleTimeout);
  }

  void _handleTimeout() {
    if (_stopWatch.isRunning) {
      _startTimeout();
    }
    setState(() {
      _setStopwatchText();
    });
  }

  void _startStopButtonPressed() {
      if (_stopWatch.isRunning) {
        _isStart = true;
        _stopWatch.stop();
      } else {
        _isStart = false;
        _stopWatch.start();
        _startTimeout();
      }
  }

  void _resetButtonPressed(){
    if(_stopWatch.isRunning){
      _startStopButtonPressed();
    }
    _stopWatch.reset();
    _setStopwatchText();
  }

  void _setStopwatchText(){
    var minutes = 4 - _stopWatch.elapsed.inMinutes%60;
    var seconds = 59 - _stopWatch.elapsed.inSeconds%60;
    _stopwatchText = (minutes).toString().padLeft(2,'0') + ':' +
        (seconds).toString().padLeft(2,'0');
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.none,
      child: Text("Espere: $_stopwatchText", style: TextStyle(
        color: Colors.grey,
        fontSize: 15,
        decoration: TextDecoration.underline,
        ),
      )
    );
  }
}
