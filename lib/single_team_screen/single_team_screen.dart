import 'package:flutter/material.dart';
import 'package:nba_fan_app/common_widgets.dart';
import 'package:nba_fan_app/constants.dart';
import 'package:nba_fan_app/single_team_screen/mid_view.dart';
import '../constants.dart';

class SingleTeamScreen extends StatelessWidget {
  final nbaTeams;
  final nbaTeamsImages;
  final teamId;

  SingleTeamScreen({this.nbaTeams, this.nbaTeamsImages, this.teamId});

  @override
  Widget build(BuildContext context) {
    print(teamId);
    return Scaffold(
        appBar: PreferredSize(
            child: PoppingAppBar(), preferredSize: const Size.fromHeight(50)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ErrorImageProvider(
                              url: nbaTeamsImages,
                            ),
                          ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Text(
                        nbaTeams,
                        style: kTeamStyleWhite,
                      ),
                    ],
                  ),
                  Text(
                    "PLAYERS",
                    style: kTeamStyleWhite,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: MidView(
                      teamId: teamId,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
