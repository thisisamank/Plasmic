import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';

/// This ViewModel controls single item of Feed page

class FeedListItemViewModel {
  VolunteerModel volunteer;
  String id;

  FeedListItemViewModel(this.volunteer, this.id);

  /// constructor to create a [FeedListViewModel] object from firebase
  factory FeedListItemViewModel.fromSnapshot(
      QueryDocumentSnapshot querySnapshot) {
    VolunteerModel volunteerModel =
        VolunteerModel.fromQuerySnapshot(querySnapshot);
    String id = querySnapshot.id;
    return FeedListItemViewModel(volunteerModel, id);
  }
}
