import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/view_model/feed/feed_list_item_view_model.dart';

/// ViewModel to control the list of Volunteers on Feed
class FeedListViewModel {
  List<FeedListItemViewModel> donors = [];
  FeedListViewModel(this.donors);

  ///constructor to create a [FeedListViewModel] object from firebase
  factory FeedListViewModel.fromSnapshot(QuerySnapshot querySnapshot) {
    var donors = querySnapshot.docs
        .map((item) => FeedListItemViewModel.fromSnapshot(item))
        .toList();
    donors.sort(
        (a, b) => a.volunteer.calledTimes.compareTo(b.volunteer.calledTimes));
    return FeedListViewModel(donors);
  }
}
