import 'package:flutter/material.dart';
import 'select_time.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'dart:developer' as developer;

class Clock extends StatefulWidget {
  @override
  ClockState createState() => ClockState();
}

class ClockState extends State<Clock> {
  static int time = 4;
  int _orginalTime = 5;
  int _firstcycle = 0;
  bool _starter;
  Timer _timer;
  Icon _currenticon = Icon(Icons.play_arrow);
  void _stoptimer() {
    _timer.cancel();
    setState(() {
      time = _orginalTime;
      _currenticon = Icon(Icons.play_arrow);
    });
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
        _orginalTime = time;
        _firstcycle = 1;
      }
      setState(() {
        _currenticon = Icon(Icons.pause);
        time;
      });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (time > 0) {
            time--;
          } else {
            FlutterRingtonePlayer.play(
              android: AndroidSounds.notification,
              ios: IosSounds.glass,
              looping: false,
              volume: 0.5,
            );
            _currenticon = Icon(Icons.play_arrow);
            _firstcycle = 0;
            _timer.cancel();
            _resetTimer();
          }
        });
      });
    }
  }

  void _resetTimer() {
    setState(() {
      time = _orginalTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Set: $time'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SelectTimeSeconds(),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SelectTimeSeconds(),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SelectTimeSeconds(),
            ),
          ],
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
