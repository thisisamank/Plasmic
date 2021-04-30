import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';

class FeedListViewModel {
  List<VolunteerModel> donars = [];
  FeedListViewModel(this.donars);
  factory FeedListViewModel.fromSnapshot(QuerySnapshot querySnapshot) {
    var donars = querySnapshot.docs
        .map((item) => VolunteerModel.fromQuerySnapshot(item))
        .toList();
    return FeedListViewModel(donars);
  }
}
