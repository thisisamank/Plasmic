import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/view_model/feed/feed_list_item_view_model.dart';
import 'package:covid_care/view_model/feed/feed_list_view_model.dart';
import 'package:covid_care/view_model/feed/feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedPage extends StatelessWidget {
  List<FeedListItemViewModel> donors;
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
                donors = feedList.donors;
                return Container(
                    width: size.width,
                    height: size.height,
                    child: ListView.builder(
                      itemCount: donors.length,
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
                                            donors[index].volunteer.name,
                                            "Name"),
                                        SizedBox(height: 8),
                                        _cardTextWidget(
                                            donors[index].volunteer.bloodGroup,
                                            "Blood Group"),
                                        SizedBox(height: 8),
                                        _cardTextWidget(
                                            '${donors[index].volunteer.city}, ${donors[index].volunteer.location}',
                                            "Location"),
                                        SizedBox(height: 8),
                                        _cardTextWidget(
                                            donors[index].volunteer.covidMonth,
                                            "Recovered\nfrom Covid"),
                                      ],
                                    ),
                                  ),
                                  _callNowButton(
                                      donors[index], feedViewModel, context)
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

  GestureDetector _callNowButton(
      FeedListItemViewModel itemViewModel, FeedViewModel viewModel, context) {
    return GestureDetector(
      onTap: () {
        Toast.show(
            "Calling ${itemViewModel.volunteer.name} for Help!😀", context);
        viewModel.updateCalled(itemViewModel);
        Uri callUri =
            Uri(scheme: 'tel', path: itemViewModel.volunteer.phoneNumber);
        launch(callUri.toString());
      },
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
        ),
        SizedBox(width: 4),
        Text(detail),
      ],
    );
  }
}
