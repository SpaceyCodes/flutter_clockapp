import 'package:clockapp/screen/clock_detail/clock.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class SelectTimeSeconds extends StatefulWidget {
  @override
  SelectTimeSecondsState createState() => SelectTimeSecondsState();
}

class SelectTimeSecondsState extends State<SelectTimeSeconds> {
  String dropdownValue = '00';
  String loly;
  Seconds() {
    List<String> intlister = new List(61);
    for (var i = 0; i < 61; i++) {
      if (i < 10) {
        loly = '0$i';
        intlister[i] = loly;
      } else {
        intlister[i] = i.toString();
      }
    }
    return intlister;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          ClockState.time = int.parse(newValue);
        });
      },
      items: Seconds().map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
