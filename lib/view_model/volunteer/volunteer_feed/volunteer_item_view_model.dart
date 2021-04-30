import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';

class VolunteerListItemViewModel {
  VolunteerModel volunteer;
  String id;

  VolunteerListItemViewModel(this.volunteer, this.id);
  factory VolunteerListItemViewModel.fromSnapshot(
      QueryDocumentSnapshot querySnapshot) {
    VolunteerModel volunteerModel =
        VolunteerModel.fromQuerySnapshot(querySnapshot);
    String id = querySnapshot.id;
    return VolunteerListItemViewModel(volunteerModel, id);
  }
}
