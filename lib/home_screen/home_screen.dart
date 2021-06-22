import 'package:flutter/material.dart';
import '../constants.dart';
import '../network/networking.dart';
import '../common_widgets.dart';
import 'game_middle_cards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var dateRaw = DateTime.now();
var dateRawS = dateRaw.toString();
var date = dateRawS.split(" ")[0];
String title = "Games";
var activeColor = Colors.white;

class _HomeScreenState extends State<HomeScreen> {
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
              title,
              style: kTeamTitleStyle,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      child: CircleButton(iconData: Icons.arrow_back_ios),
                      onTap: () {
                        substractDataTime();
                      }),
                  Text(
                    date,
                    style: kDateStyle,
                  ),
                  GestureDetector(
                      child: CircleButton(
                        iconData: Icons.arrow_forward_ios,
                        color: dateRaw.isBefore(
                                DateTime.now().add(Duration(days: -1)))
                            ? activeColor
                            : kScaffoldBgColor,
                      ),
                      onTap: () {
                        addDataTime();
                      })
                ],
              ),
            ),
            GameMiddleCards(
              networkHelper: _networkHelper,
              date: date,
            )
          ],
        ),
      ),
    );
  }

  void substractDataTime() {
    setState(() {
      dateRaw = dateRaw.add(const Duration(days: -1));
      dateRawS = dateRaw.toString();
      date = dateRawS.split(" ")[0];
    });
  }

  void addDataTime() {
    //IF condition for using only past games
    var now = DateTime.now();
    setState(() {
      if (dateRaw.isBefore(now.add(Duration(days: -1)))) {
        dateRaw = dateRaw.add(const Duration(days: 1));
        dateRawS = dateRaw.toString();
        date = dateRawS.split(" ")[0];
      }
    });
  }
}
