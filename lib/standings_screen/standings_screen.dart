import 'package:flutter/material.dart';
import 'package:nba_fan_app/network/networking.dart';
import 'package:nba_fan_app/standings_screen/mid_view.dart';
import '../common_widgets.dart';
import '../constants.dart';

class StandingsScreen extends StatefulWidget {
  @override
  _StandingsScreenState createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  NetworkHelper _networkHelper = NetworkHelper();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 32.0, bottom: 32.0, left: 24.0, right: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Standings",
              style: kTeamTitleStyle,
            ),
            StandingsTable(
              networkHelper: _networkHelper,
            ),
          ],
        ),
      ),
    );
  }
}

class StandingsTable extends StatelessWidget {
  final NetworkHelper networkHelper;
  StandingsTable({
    this.networkHelper,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: FutureBuilder(
        future: networkHelper.getStandings(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var teamName = snapshot.data[index].teamName;
                  var winCounter = snapshot.data[index].win;
                  var loseCounter = snapshot.data[index].loss;
                  var winPercentage = snapshot.data[index].winPercentage;
                  return MidView(
                    teamName: teamName,
                    winCounter: winCounter,
                    loseCounter: loseCounter,
                    winPercentage: winPercentage,
                    index: index,
                  );
                });
          } else {
            return ProgressCircle();
          }
        },
      ),
    );
  }
}
