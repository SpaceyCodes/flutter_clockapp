import 'package:flutter/material.dart';
import 'select_time_hours.dart';
import 'select_time_minutes.dart';
import 'select_time_seconds.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'dart:developer' as developer;

class Clock extends StatefulWidget {
  @override
  ClockState createState() => ClockState();
}

class ClockState extends State<Clock> {
  static int secondsTime = 0;
  static int minutesTime = 0;
  static int hoursTime = 0;
  String _displaysecondsTime = '00';
  String _displayminutesTime = '00';
  String _displayhoursTime = '00';
  int _temptime1 = 0;
  int _temptime2 = 0;
  String _tempStr;
  double _opacity = 1.0;
  double _opacitytime = 0.0;
  bool _ignore = false;
  int _time = 0;
  int _orginalTime = 5;
  int _firstcycle = 0;
  bool _starter;
  Timer _timer;
  Icon _currenticon = Icon(Icons.play_arrow);
  _caltime() {
    _time = (secondsTime) + (minutesTime * 60) + (hoursTime * 60 * 60);
    return _time;
  }

  _caldisplaytime() {
    _temptime1 = _time;
    _temptime2 = (_temptime1 ~/ 60 ~/ 60);
    if (_temptime2 < 10) {
      _tempStr = '0$_temptime2';
      _displayhoursTime = _tempStr;
    } else {
      _displayhoursTime = _temptime2.toString();
    }
    _temptime1 = _temptime1 - (_temptime1 ~/ 3600) * 3600;
    _temptime2 = (_temptime1 ~/ 60);
    if (_temptime2 < 10) {
      _tempStr = '0$_temptime2';
      _displayminutesTime = _tempStr;
    } else {
      _displayminutesTime = _temptime2.toString();
    }
    _temptime1 = _temptime1 - (_temptime1 ~/ 60) * 60;
    _temptime2 = (_temptime1);
    if (_temptime2 < 10) {
      _tempStr = '0$_temptime2';
      _displaysecondsTime = _tempStr;
    } else {
      _displaysecondsTime = _temptime2.toString();
    }
    setState(() {
      _displayhoursTime;
      _displayminutesTime;
      _displaysecondsTime;
    });
  }

  _changestate() {
    if (_opacity == 1.0) {
      setState(() {
        _opacity = 0.4;
        _ignore = true;
      });
    } else {
      _opacity = 1.0;
      _ignore = false;
    }
  }

  void _stoptimer() {
    if (_firstcycle == 1) {
      _timer.cancel();
      setState(() {
        _opacitytime = 0.0;
        _changestate();
        _time = _orginalTime;
        _caldisplaytime();
        _firstcycle = 0;
        _currenticon = Icon(Icons.play_arrow);
      });
    }
  }

  void _startTimer() {
    try {
      _starter = _timer.isActive;
    } on NoSuchMethodError {
      _starter = false;
    }
    if (_starter) {
      developer.log('ahyo1');
      setState(() {
        _currenticon = Icon(Icons.play_arrow);
      });
      _timer.cancel();
    } else {
      if (_firstcycle == 0) {
        _changestate();
        _time = _caltime();
        _orginalTime = _time;
        _firstcycle = 1;
      }
      _caldisplaytime();
      setState(() {
        _currenticon = Icon(Icons.pause);
        _time;
        _opacitytime = 1.0;
      });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_time > 0) {
          _time--;
          _caldisplaytime();
        } else {
          setState(() {
            FlutterRingtonePlayer.play(
              android: AndroidSounds.notification,
              ios: IosSounds.glass,
              looping: true,
              volume: 0.5,
            );
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                      title: Text("Time's up"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              FlutterRingtonePlayer.stop();
                            },
                            child: Text('Stop'))
                      ],
                    ));
            _currenticon = Icon(Icons.play_arrow);
            _firstcycle = 0;
            _changestate();
            _timer.cancel();
            _opacitytime = 0.0;
            _resetTimer();
          });
        }
      });
    }
  }

  void _resetTimer() {
    _time = _orginalTime;
    _caldisplaytime();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
            opacity: _opacitytime,
            child: Text(
              '$_displayhoursTime $_displayminutesTime $_displaysecondsTime',
              style: TextStyle(fontSize: 25),
            )),
        Opacity(
          opacity: _opacity,
          child: IgnorePointer(
            ignoring: _ignore,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SelectTimeHours(),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SelectTimeMinutes(),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SelectTimeSeconds(),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.stop),
              color: Colors.red,
              iconSize: 50,
              onPressed: () {
                _stoptimer();
              },
            ),
            IconButton(
              icon: _currenticon,
              color: Colors.red,
              iconSize: 50,
              onPressed: () {
                _startTimer();
              },
            ),
          ],
        ),
      ],
    );
  }
}
