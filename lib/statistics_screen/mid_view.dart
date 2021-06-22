import 'package:flutter/material.dart';
import 'package:nba_fan_app/constants.dart';

import '../common_widgets.dart';
import '../network/networking.dart';

class MidView extends StatelessWidget {
  final String gameId;
  const MidView({this.gameId});

  @override
  Widget build(BuildContext context) {
    NetworkHelper _networkHelper = NetworkHelper();
    return Expanded(
      child: Container(
        child: FutureBuilder(
            future: _networkHelper.getGameInfo(gameId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Team statistics",
                      style: kCityTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        buildTeamStatistics(snapshot, 0),
                        Column(
                          children: [
                            Text("Fastbreak points"),
                            Text("Points in paint"),
                            Text("Points off turnovers"),
                            Text("Field Goal Percentage"),
                            Text("Assists"),
                            Text("Steals"),
                            Text("Blocks"),
                            Text("Turnovers")
                          ],
                        ),
                        buildTeamStatistics(snapshot, 1)
                      ],
                    ),
                  ],
                );
              } else {
                return ProgressCircle(
                  color: kScaffoldBgColor,
                );
              }
            }),
      ),
    );
  }

  TeamStatistics buildTeamStatistics(AsyncSnapshot snapshot, int index) {
    return TeamStatistics(
      fastBreakPoints: snapshot.data[index].fastBreakPoints,
      pointsinPaint: snapshot.data[index].pointsinPaint,
      pointsOffTurnovers: snapshot.data[index].pointsOffTurnovers,
      fgp: snapshot.data[index].fgp,
      assist: snapshot.data[index].assists,
      steals: snapshot.data[index].steals,
      block: snapshot.data[index].blocks,
      turnovers: snapshot.data[index].turnovers,
    );
  }
}

class TeamStatistics extends StatelessWidget {
  final String fastBreakPoints;
  final String pointsinPaint;
  final String pointsOffTurnovers;
  final String fgp;
  final String totReb;
  final String offReb;
  final String defReb;
  final String assist;
  final String steals;
  final String block;
  final String turnovers;

  const TeamStatistics(
      {this.fastBreakPoints,
      this.pointsinPaint,
      this.pointsOffTurnovers,
      this.fgp,
      this.totReb,
      this.offReb,
      this.defReb,
      this.assist,
      this.steals,
      this.block,
      this.turnovers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(fastBreakPoints),
        Text(pointsinPaint),
        Text(pointsOffTurnovers),
        Text("$fgp %"),
        Text(assist),
        Text(steals),
        Text(block),
        Text(turnovers)
      ],
    );
  }
}
