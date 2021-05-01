import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';
import 'package:covid_care/view_model/feed/feed_list_item_view_model.dart';
import 'package:covid_care/view_model/volunteer/volunteer_feed/volunteer_item_view_model.dart';
import 'package:flutter/cupertino.dart';

class FeedViewModel extends ChangeNotifier {
  var _currentLocation = 'Delhi';
  var _currentBloodGroup = 'O+';
  List<VolunteerModel> donars = [];

  Stream donarsAsStream() => FirebaseFirestore.instance
      .collection('plasma')
      .doc(_currentLocation)
      .collection(_currentLocation)
      .where('bloodGroup', isEqualTo: _currentBloodGroup)
      .snapshots();

  void changeLocation(String location) {
    _currentLocation = location;
    notifyListeners();
  }

  void updateCalled(FeedListItemViewModel itemViewModel) {
    FirebaseFirestore.instance
        .collection('plasma')
        .doc(_currentLocation)
        .collection(_currentLocation)
        .doc(itemViewModel.id)
        .update({'calledTimes': itemViewModel.volunteer.calledTimes + 1});
    notifyListeners();
  }

  void changeBloodGroup(String bloodGroup) {
    _currentBloodGroup = bloodGroup;
    notifyListeners();
  }
}
