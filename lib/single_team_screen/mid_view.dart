import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nba_fan_app/common_widgets.dart';
import 'package:nba_fan_app/constants.dart';
import 'package:nba_fan_app/network/networking.dart';

class MidView extends StatelessWidget {
  final String teamId;

  MidView({@required this.teamId});

  @override
  Widget build(BuildContext context) {
    NetworkHelper _networkHelper = NetworkHelper();
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: FutureBuilder(
            future: _networkHelper.getTeamRoster(teamId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Swiper(
                  itemCount: snapshot.data.length,
                  itemWidth: 200,
                  layout: SwiperLayout.STACK,
                  itemBuilder: (context, index) {
                    var firstName = snapshot.data[index].firstName;
                    var lastName = snapshot.data[index].lastName;
                    var country = snapshot.data[index].country;
                    var dateOfBirth = snapshot.data[index].dateOfBirth;
                    var heightInMeters = snapshot.data[index].heightInMeters;
                    var weightInKilograms =
                        snapshot.data[index].weightinKilograms;
                    return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: kScaffoldBgColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              firstName,
                              style: kPlayerFirstNameRosterStyle,
                            ),
                            Text(
                              lastName,
                              style: kPlayerLastNameRosterStyle,
                            ),
                            Text(
                              dateOfBirth,
                              style: kArenaTextStyle,
                            ),
                            Text(
                              country,
                              style: kArenaTextStyle,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Height [m] : $heightInMeters"),
                                Text("Weight [kg] : $weightInKilograms")
                              ],
                            )
                          ],
                        ));
                  },
                );
              } else {
                return ProgressCircle();
              }
            }));
  }
}
