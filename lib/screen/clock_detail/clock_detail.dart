import 'package:flutter/material.dart';
import 'clock.dart';

class Clock_detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Clock(),
        ],
      ),
    );
  }
}
