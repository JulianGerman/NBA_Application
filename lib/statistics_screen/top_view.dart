import 'package:flutter/cupertino.dart';
import '../common_widgets.dart';

class TopView extends StatelessWidget {
  const TopView({
    Key key,
    @required this.hteamName,
    @required this.vteamName,
    @required this.hteamScore,
    @required this.vteamScore,
    @required this.gameId,
    @required this.index,
    @required this.hteamLogo,
    @required this.vteamLogo,
    @required this.arena,
    @required this.city,
  }) : super(key: key);

  final String hteamName;
  final String vteamName;
  final String hteamScore;
  final String vteamScore;
  final String gameId;
  final int index;
  final String hteamLogo;
  final String vteamLogo;
  final String arena;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              TeamDetail(
                teamName: vteamName,
                url: vteamLogo,
                width: 50,
                heigth: 50,
              ),
              MiddleScore(
                arena: arena,
                city: city,
                vTeamScore: vteamScore,
                hTeamScore: hteamScore,
              ),
              TeamDetail(
                teamName: hteamName,
                url: hteamLogo,
                width: 50,
                heigth: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}
