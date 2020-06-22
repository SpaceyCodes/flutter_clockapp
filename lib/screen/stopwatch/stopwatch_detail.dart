import 'package:flutter/material.dart';
import 'stopwatch.dart';

class Stopwatch_detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stopwatch(),
        ],
      ),
    );
  }
}
