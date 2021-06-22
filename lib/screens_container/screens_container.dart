import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nba_fan_app/home_screen/home_screen.dart';
import 'package:nba_fan_app/standings_screen/standings_screen.dart';
import 'package:nba_fan_app/teams_screen/teams_screen.dart';
import '../constants.dart';

class ScreensContainer extends StatefulWidget {
  @override
  _ScreensContainerState createState() => _ScreensContainerState();
}

class _ScreensContainerState extends State<ScreensContainer> {
  static List<String> nbaTeams = [];
  static List<String> nbaTeamsImage = [];

  //BOTTOM NAVIGATION BAR
  List<Widget> _screenOption = [
    StandingsScreen(),
    HomeScreen(),
    TeamsScreen(
      nbaTeams: nbaTeams,
      nbaTeamsImages: nbaTeamsImage,
    )
  ];
  int bottomIndex = 1;
  double iconSize = 30.0;
  void _onTap(int index) {
    setState(() {
      bottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screenOption.elementAt(bottomIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          items: [
            Icon(
              LineAwesomeIcons.trophy,
              size: iconSize,
            ),
            Icon(
              LineAwesomeIcons.basketball_ball,
              size: iconSize,
            ),
            Icon(
              IcoFontIcons.people,
              size: iconSize,
            ),
          ],
          backgroundColor: kScaffoldBgColor,
          animationDuration: Duration(milliseconds: 350),
          index: bottomIndex,
          onTap: _onTap),
    );
  }
}
