import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';
import 'package:covid_care/view_model/feed/feed_list_item_view_model.dart';

class FeedListViewModel {
  List<FeedListItemViewModel> donars = [];
  FeedListViewModel(this.donars);
  factory FeedListViewModel.fromSnapshot(QuerySnapshot querySnapshot) {
    var donars = querySnapshot.docs
        .map((item) => FeedListItemViewModel.fromSnapshot(item))
        .toList();
    donars.sort(
        (a, b) => a.volunteer.calledTimes.compareTo(b.volunteer.calledTimes));
    return FeedListViewModel(donars);
  }
}
