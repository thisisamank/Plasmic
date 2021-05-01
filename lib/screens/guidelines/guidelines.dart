import 'package:covid_care/constants/colors.dart';
import 'package:flutter/material.dart';

class GuidelinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Center(
            child: Text("Guidelines"),
          ),
        ),
        GestureDetector(
          onTap: () {},
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
