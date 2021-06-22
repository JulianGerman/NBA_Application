import 'package:flutter/material.dart';
import 'package:nba_fan_app/single_team_screen/single_team_screen.dart';
import '../common_widgets.dart';
import '../network/networking.dart';

class MidView extends StatelessWidget {
  const MidView({
    Key key,
    @required NetworkHelper networkHelper,
  })  : _networkHelper = networkHelper,
        super(key: key);

  final NetworkHelper _networkHelper;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: FutureBuilder(
            future: _networkHelper.getOnlyNBATeams(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                child: ErrorImageProvider(
                                  url: snapshot.data[index].teamLogo,
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return SingleTeamScreen(
                                        nbaTeamsImages:
                                            snapshot.data[index].teamLogo,
                                        nbaTeams: snapshot.data[index].fullName,
                                        teamId: snapshot.data[index].teamId,
                                      );
                                    },
                                  ));
                                }));
                      }),
                );
              } else {
                return ProgressCircle();
              }
            }),
      ),
    );
  }
}
