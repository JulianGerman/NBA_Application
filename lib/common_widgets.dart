import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'constants.dart';

class ProgressCircle extends StatelessWidget {
  final Color color;

  const ProgressCircle({Key key, this.color = Colors.white});
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitRipple(
      color: color,
    ));
  }
}

class ErrorImageProvider extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  ErrorImageProvider({this.url, this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: url,
        placeholder: (context, url) => new ProgressCircle(
          color: kScaffoldBgColor,
        ),
        errorWidget: (context, url, error) =>
            new Icon(LineAwesomeIcons.basketball_ball),
      ),
    );
  }
}

class TeamDetail extends StatelessWidget {
  final String url;
  final String teamName;
  final double width;
  final double heigth;
  TeamDetail(
      {@required this.url,
      @required this.teamName,
      @required this.width,
      @required this.heigth});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
        ErrorImageProvider(
          url: url,
          width: width,
          height: heigth,
        ),
        Text(teamName),
      ]),
    );
  }
}

class MiddleScore extends StatelessWidget {
  final String city;
  final String arena;
  final String vTeamScore;
  final String hTeamScore;
  MiddleScore({this.city, this.arena, this.vTeamScore, this.hTeamScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 14,
              ),
              Text(
                city,
                style: kCityTextStyle,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
            child: Text(
              arena,
              style: kArenaTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "$vTeamScore - $hTeamScore",
            style: kScoreTextStyle,
          ),
        ],
      ),
    );
  }
}

class PoppingAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kScaffoldBgColor,
      leading: GestureDetector(
        child: Icon(Icons.arrow_back_ios),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  CircleButton({this.iconData, this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        iconData,
        color: color,
      ),
    );
  }
}
