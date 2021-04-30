import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/view_model/volunteer/volunteer_feed/volunteer_feed_view_model.dart';
import 'package:covid_care/view_model/volunteer/volunteer_feed/volunteer_item_view_model.dart';
import 'package:covid_care/view_model/volunteer/volunteer_feed/volunteer_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class VolunteerFeed extends StatelessWidget {
  List<VolunteerListItemViewModel> volunteers;
  Size size;
  TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    textTheme = Theme.of(context).textTheme;
    return Consumer(
      builder: (context, VolunteerFeedViewModel volunteerFeedViewModel, child) {
        return StreamBuilder<QuerySnapshot>(
            stream: volunteerFeedViewModel.volunteerDetailsAsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final feedList =
                    VolunteerListViewModel.fromSnapshot(snapshot.data);
                volunteers = feedList.volunteers;
                return Expanded(
                    child: ListView.builder(
                  itemCount: volunteers.length,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  children: [
                                    SizedBox(height: 8),
                                    _cardTextWidget(
                                        volunteers[index].volunteer.name,
                                        "Name"),
                                    SizedBox(height: 8),
                                    _cardTextWidget(
                                        volunteers[index].volunteer.bloodGroup,
                                        "Blood Group"),
                                    SizedBox(height: 8),
                                    _cardTextWidget(
                                        volunteers[index].volunteer.location,
                                        "Location"),
                                    SizedBox(height: 8),
                                    _cardTextWidget(
                                        volunteers[index].volunteer.covidMonth,
                                        "Recovered\nfrom Covid"),
                                  ],
                                ),
                              ),
                              _pauseAndDeleteButton(() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          width: 250,
                                          height: 100,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 10),
                                              Text("Are you sure?"),
                                              SizedBox(height: 10),
                                              MaterialButton(
                                                minWidth: 100,
                                                onPressed: () {
                                                  volunteerFeedViewModel
                                                      .deleteVolunteer(
                                                          volunteers[index]);
                                                  Toast.show(
                                                      "Volunteer deleted sucessfully!",
                                                      context);
                                                  Navigator.pop(context);
                                                },
                                                color: BrandColors.red,
                                                textColor: Colors.white,
                                                child: Text("Delete"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              })
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

  Widget _pauseAndDeleteButton(onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          color: BrandColors.red,
        ),
        child: Center(
          child: Text(
            "Delete",
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
