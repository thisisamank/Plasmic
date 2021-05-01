import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/routes/route_constants.dart';
import 'package:covid_care/screens/home/home_screen.dart';
import 'package:covid_care/screens/volunteer/volunteer_feed/volunteer_feed.dart';
import 'package:flutter/material.dart';

class VolunteerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VolunteerFeed(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.plasmaVolunteerRegister);
            },
            child: Container(
              height: 50,
              width: size.width,
              decoration: BoxDecoration(
                color: BrandColors.blue,
              ),
              child: Center(
                child: Text(
                  "Register a new donor",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: BrandColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
