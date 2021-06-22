import 'package:flutter/material.dart';
import 'package:nba_fan_app/constants.dart';
import '../constants.dart';
import '../network/networking.dart';
import 'mid_view.dart';

class TeamsScreen extends StatelessWidget {
  final NetworkHelper _networkHelper = NetworkHelper();
  final nbaTeams;
  final nbaTeamsImages;
  TeamsScreen({this.nbaTeams, this.nbaTeamsImages});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 32.0, bottom: 32.0, left: 24.0, right: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Teams',
              style: kTeamTitleStyle,
            ),
            MidView(networkHelper: _networkHelper),
          ],
        ),
      ),
    );
  }
}
