import 'package:clockapp/screen/clock_detail/clock.dart';
import 'package:flutter/material.dart';

class SelectTimeHours extends StatefulWidget {
  @override
  SelectTimeHoursState createState() => SelectTimeHoursState();
}

class SelectTimeHoursState extends State<SelectTimeHours> {
  String dropdownValue = '00';
  String loly;
  _Seconds() {
    List<String> intlister = new List(100);
    for (var i = 0; i < 100; i++) {
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
          ClockState.hoursTime = int.parse(newValue);
        });
      },
      items: _Seconds().map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
