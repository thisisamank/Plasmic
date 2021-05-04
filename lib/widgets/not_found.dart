import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VolunteerNotFound extends StatelessWidget {
  final title;
  VolunteerNotFound(this.title);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'images/add-volunteer.svg',
            width: 300,
          ),
          SizedBox(height: 40),
          Text(title),
        ],
      ),
    );
  }
}
