import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Stopwatch extends StatefulWidget {
  @override
  StopwatchState createState() => StopwatchState();
}

class StopwatchState extends State<Stopwatch> {
  Icon _currentIcon = Icon(Icons.play_arrow);
  Row _rowler;
  int _stopwatchTime = 0;
  int _lapNumber = 0;
  bool _starter;
  Timer _stopwatchTimer;
  String _displayhoursTime = '00';
  String _displayminutesTime = '00';
  String _displaysecondsTime = '00';
  String _displaymillisecondsTime = '0';
  String _tempStr;
  int _temptime1;
  int _temptime2;
  double _opacity = 0.3;
  bool _ignore = true;
  void _calStopwatchTime() {
    _temptime1 = _stopwatchTime;
    _temptime2 = (_temptime1 ~/ 36000);
    if (_temptime2 < 10) {
      _tempStr = '0$_temptime2';
      _displayhoursTime = _tempStr;
    } else {
      _displayhoursTime = _temptime2.toString();
    }
    _temptime1 = _temptime1 - (_temptime2) * 36000;
    _temptime2 = (_temptime1 ~/ 600);
    if (_temptime2 < 10) {
      _tempStr = '0$_temptime2';
      _displayminutesTime = _tempStr;
    } else {
      _displayminutesTime = _temptime2.toString();
    }
    _temptime1 = _temptime1 - (_temptime2) * 600;
    _temptime2 = (_temptime1 ~/ 10);
    if (_temptime2 < 10) {
      _tempStr = '0$_temptime2';
      _displaysecondsTime = _tempStr;
    } else {
      _displaysecondsTime = _temptime2.toString();
    }
    _temptime1 = _temptime1 - (_temptime2) * 10;
    _displaymillisecondsTime = _temptime1.toString();
    setState(() {
      _displayhoursTime;
      _displayminutesTime;
      _displaysecondsTime;
      _displaymillisecondsTime;
    });
  }

  void _startStopwatchTimer() {
    try {
      _starter = _stopwatchTimer.isActive;
    } on NoSuchMethodError {
      _starter = false;
    }
    if (_starter) {
      _stopwatchTimer.cancel();
      setState(() {
        _currentIcon = Icon(Icons.play_arrow);
      });
    } else {
      setState(() {
        _currentIcon = Icon(Icons.pause);
        _ignore = false;
        _opacity = 1.0;
      });
      _stopwatchTimer =
          Timer.periodic(Duration(milliseconds: 100), (_stopwatchTimer) {
        _stopwatchTime++;
        _calStopwatchTime();
      });
    }
  }

  void _restartStopwatchTimer() {
    _stopwatchTimer.cancel();
    _stopwatchTime = 0;
    _calStopwatchTime();
    listlap = [];
    _lapNumber = 0;
    setState(() {
      _currentIcon = Icon(Icons.play_arrow);
      _ignore = true;
      _opacity = 0.3;
    });
  }

  _lapString() {
    _lapNumber++;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.5,
          child: Text(
            '$_lapNumber      ',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Text(
            '$_displayhoursTime',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Text(
            ':$_displayminutesTime',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Text(
            ':$_displaysecondsTime',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Text(
            ':$_displaymillisecondsTime',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
      ],
    );
  }

  List<Widget> listlap = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$_displayhoursTime:$_displayminutesTime:$_displaysecondsTime:$_displaymillisecondsTime',
          style: TextStyle(fontSize: 25),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.stop),
              color: Colors.red,
              iconSize: 50,
              onPressed: () {
                _restartStopwatchTimer();
              },
            ),
            IconButton(
              icon: _currentIcon,
              color: Colors.red,
              iconSize: 50,
              onPressed: () {
                _startStopwatchTimer();
              },
            ),
            Opacity(
                opacity: _opacity,
                child: IgnorePointer(
                  ignoring: _ignore,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.red,
                    iconSize: 50,
                    onPressed: () {
                      _rowler = _lapString();
                      setState(() {
                        listlap.insert(0, _rowler);
                      });
                    },
                  ),
                )),
          ],
        ),
        NotificationListener(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: Container(
              height: 250,
              child: ListView(reverse: false, children: [
                Column(children: listlap),
              ]),
            )),
      ],
    );
  }
}
