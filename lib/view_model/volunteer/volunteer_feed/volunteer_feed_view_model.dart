import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/view_model/volunteer/volunteer_feed/volunteer_item_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class VolunteerFeedViewModel extends ChangeNotifier {
  Stream get volunteerDetailsAsStream => FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('volunteers')
      .where('isPaused', isEqualTo: false)
      .snapshots();

  void deleteVolunteer(VolunteerListItemViewModel viewModel) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('volunteers')
        .doc(viewModel.id)
        .delete();
    FirebaseFirestore.instance
        .collection('plasma')
        .doc(viewModel.volunteer.location)
        .collection(viewModel.volunteer.location)
        .doc(viewModel.id)
        .delete();
  }

  /// this method is not currently in use but plan is to implement feature of pausing account
  /// there this will come handy
  void pauseVolunteer(VolunteerListItemViewModel viewModel) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('volunteers')
        .doc(viewModel.id)
        .update({'isPaused': true});
    FirebaseFirestore.instance
        .collection('plasma')
        .doc(viewModel.volunteer.location)
        .collection(viewModel.volunteer.location)
        .doc(viewModel.id)
        .delete();
  }
}
