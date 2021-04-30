import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';
import 'package:covid_care/view_model/volunteer/volunteer_feed/volunteer_item_view_model.dart';

class VolunteerListViewModel {
  List<VolunteerListItemViewModel> volunteers = [];
  VolunteerListViewModel(this.volunteers);
  factory VolunteerListViewModel.fromSnapshot(QuerySnapshot querySnapshot) {
    var donars = querySnapshot.docs
        .map((item) => VolunteerListItemViewModel.fromSnapshot(item))
        .toList();
    return VolunteerListViewModel(donars);
  }
}
