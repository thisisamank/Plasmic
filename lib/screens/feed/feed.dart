import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/models/volunteer_model.dart';
import 'package:covid_care/view_model/feed/feed_list_view_model.dart';
import 'package:covid_care/view_model/feed/feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  List<VolunteerModel> donars;
  Size size;
  TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    return Consumer(
      builder: (context, FeedViewModel feedViewModel, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: feedViewModel.donarsAsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final feedList = FeedListViewModel.fromSnapshot(snapshot.data);
                donars = feedList.donars;
                return Container(
                    width: size.width,
                    height: size.height,
                    child: ListView.builder(
                      itemCount: donars.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: BrandColors.lightBlue,
                              ),
                              height: 200,
                              width: size.width * .8,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8),
                                        _cardTextWidget(
                                            donars[index].name, "Name"),
                                        SizedBox(height: 8),
                                        _cardTextWidget(
                                            donars[index].bloodGroup,
                                            "Blood Group"),
                                        SizedBox(height: 8),
                                        _cardTextWidget(
                                            donars[index].location, "Location"),
                                        SizedBox(height: 8),
                                        _cardTextWidget(
                                            donars[index].covidMonth,
                                            "Recovered\nfrom Covid"),
                                      ],
                                    ),
                                  ),
                                  _callNowButton()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ));
              } else
                return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: BrandColors.blue));
            });
      },
    );
  }

  GestureDetector _callNowButton() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          color: BrandColors.blue,
        ),
        child: Center(
          child: Text(
            "Call Now",
            style: textTheme.bodyText2.copyWith(
              color: BrandColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        width: size.width * .8,
        height: 40,
      ),
    );
  }

  Widget _cardTextWidget(String detail, String title) {
    return Row(
      children: [
        Text(
          "$title : ",
          style: textTheme.bodyText1.copyWith(fontSize: 18.0),
        ),
        SizedBox(width: 4),
        Text(detail),
      ],
    );
  }
}
