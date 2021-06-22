import 'package:flutter/material.dart';
import 'package:nba_fan_app/statistics_screen/top_view.dart';

import '../common_widgets.dart';
import 'mid_view.dart';

class StatisticsScreen extends StatelessWidget {
  final String hteamLogo;
  final String hteamName;
  final String vteamLogo;
  final String vteamName;
  final String vteamScore;
  final String hteamScore;
  final String gameId;
  final int index;
  final String arena;
  final String city;

  const StatisticsScreen(
      {this.hteamLogo,
      this.hteamName,
      this.index,
      this.vteamLogo,
      this.vteamName,
      this.vteamScore,
      this.hteamScore,
      this.gameId,
      this.arena,
      this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: PoppingAppBar(), preferredSize: const Size.fromHeight(50)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopView(
                hteamName: hteamName,
                vteamName: vteamName,
                hteamScore: hteamScore,
                vteamScore: vteamScore,
                gameId: gameId,
                index: index,
                hteamLogo: hteamLogo,
                vteamLogo: vteamLogo,
                arena: arena,
                city: city,
              ),
              MidView(
                gameId: gameId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
