import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';
import 'package:covid_care/view_model/feed/feed_list_item_view_model.dart';
import 'package:flutter/cupertino.dart';

///ViewModel to control the Feed
class FeedViewModel extends ChangeNotifier {
  /// default location
  var _currentLocation = 'Delhi';

  /// default blood group
  var _currentBloodGroup = 'O+';
  List<VolunteerModel> donars = [];

  /// method to return a [Stream] of [donars] from firebase based on [currentLocation]
  /// and [currentBloodGroup]
  Stream donarsAsStream() => FirebaseFirestore.instance
      .collection('plasma')
      .doc(_currentLocation)
      .collection(_currentLocation)
      .where('bloodGroup', isEqualTo: _currentBloodGroup)
      .snapshots();

  /// method to change the currentLocation
  void changeLocation(String location) {
    _currentLocation = location;
    notifyListeners();
  }

  ///method to increase the value of [calledTimes]
  ///here  [calledTimes] refers to how many times a donar is called
  void updateCalled(FeedListItemViewModel itemViewModel) {
    FirebaseFirestore.instance
        .collection('plasma')
        .doc(_currentLocation)
        .collection(_currentLocation)
        .doc(itemViewModel.id)
        .update({'calledTimes': itemViewModel.volunteer.calledTimes + 1});
    notifyListeners();
  }

  /// method to change the currentBloodGroup
  void changeBloodGroup(String bloodGroup) {
    _currentBloodGroup = bloodGroup;
    notifyListeners();
  }
}
