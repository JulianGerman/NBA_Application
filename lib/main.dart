import 'package:flutter/material.dart';
import 'package:nba_fan_app/constants.dart';
import 'package:nba_fan_app/screens_container/screens_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: ThemeData.light(
        // )
        //     .copyWith(scaffoldBackgroundColor: kScaffoldBgColor, ),
        theme: ThemeData(
          fontFamily: "Rajdhani",
          scaffoldBackgroundColor: kScaffoldBgColor,
        ),
        home: ScreensContainer());
  }
}
