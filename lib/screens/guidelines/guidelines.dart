import 'package:covid_care/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          child: Text(""),
        ),
        Text("Guidelines and more resources \nto be added soon"),
        GestureDetector(
          onTap: () {
            Share.share(
                'Download Plasmic to get in touch with plasma donars. link: https://play.google.com/store/apps/details?id=com.visnstudios.covid_care');
          },
          child: Container(
            height: 50,
            width: size.width,
            decoration: BoxDecoration(
              color: BrandColors.blue,
            ),
            child: Center(
              child: Text(
                "Share this App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: BrandColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
