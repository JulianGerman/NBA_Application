import 'package:flutter/material.dart';
import 'package:nba_fan_app/statistics_screen/statistics_screen.dart';

import '../common_widgets.dart';
import '../network/networking.dart';

class GameMiddleCards extends StatelessWidget {
  const GameMiddleCards({
    Key key,
    @required NetworkHelper networkHelper,
    this.date,
  })  : _networkHelper = networkHelper,
        super(key: key);

  final NetworkHelper _networkHelper;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: FutureBuilder(
            future: _networkHelper.getLatestGames(date),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Hero(
                          tag: "statisticsScreen",
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TeamDetail(
                                        url: snapshot.data[index].vTeamLogo,
                                        teamName:
                                            snapshot.data[index].vNickname,
                                        width: 35,
                                        heigth: 35,
                                      ),
                                      MiddleScore(
                                        city: snapshot.data[index].city,
                                        arena: snapshot.data[index].arena,
                                        vTeamScore:
                                            snapshot.data[index].vTeamScore,
                                        hTeamScore:
                                            snapshot.data[index].hTeamScore,
                                      ),
                                      TeamDetail(
                                        url: snapshot.data[index].hTeamLogo,
                                        teamName:
                                            snapshot.data[index].hNickname,
                                        width: 35,
                                        heigth: 35,
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.arrow_forward, size: 12.0),
                                    Text(
                                      "tap for more ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            print(snapshot.data[index].gameId);
                            return StatisticsScreen(
                              // teamLogo: snapshot.data[index].hTeamlogo,
                              hteamName: snapshot.data[index].hNickname,
                              hteamLogo: snapshot.data[index].hTeamLogo,
                              hteamScore: snapshot.data[index].hTeamScore,
                              vteamName: snapshot.data[index].vNickname,
                              vteamLogo: snapshot.data[index].vTeamLogo,
                              vteamScore: snapshot.data[index].vTeamScore,
                              index: index,
                              arena: snapshot.data[index].arena,
                              city: snapshot.data[index].city,
                              gameId: snapshot.data[index].gameId,
                            );
                          }));
                        },
                      );
                    });
              } else {
                return ProgressCircle();
              }
            }),
      ),
    );
  }
}
