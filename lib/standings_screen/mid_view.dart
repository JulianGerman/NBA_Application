import 'package:flutter/material.dart';
import 'package:nba_fan_app/constants.dart';

class MidView extends StatelessWidget {
  const MidView(
      {@required this.teamName,
      @required this.winCounter,
      @required this.loseCounter,
      @required this.winPercentage,
      @required this.index});

  final teamName;
  final winCounter;
  final loseCounter;
  final winPercentage;
  final index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "${index + 1}. ",
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          teamName,
                          style: kTeamStyleBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        children: [
                          Text(" W - L "),
                          Text("$winCounter-$loseCounter"),
                        ],
                      ),
                    ),
                    Column(
                      children: [Text("WIN %"), Text("$winPercentage %")],
                    )
                  ],
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
