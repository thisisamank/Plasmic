import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';

class FeedListItemViewModel {
  VolunteerModel volunteer;
  String id;

  FeedListItemViewModel(this.volunteer, this.id);
  factory FeedListItemViewModel.fromSnapshot(
      QueryDocumentSnapshot querySnapshot) {
    VolunteerModel volunteerModel =
        VolunteerModel.fromQuerySnapshot(querySnapshot);
    String id = querySnapshot.id;
    return FeedListItemViewModel(volunteerModel, id);
  }
}
