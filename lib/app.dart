import 'package:flutter/material.dart';
import 'screen/clock_detail/clock_detail.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: ColorfulSafeArea(
            color: Colors.deepPurpleAccent,
            child: Scaffold(
              appBar: TabBar(
                labelPadding: EdgeInsets.all(10.0),
                tabs: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.deepPurpleAccent,
                      ),
                      Text(
                        'Timer',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.deepPurpleAccent,
                      ),
                      Text(
                        'Stopwatch',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              body: TabBarView(children: [
                Clock_detail(),
                Clock_detail(),
              ]),
            ),
          ),
        ));
  }
}
