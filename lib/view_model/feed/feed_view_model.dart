import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';
import 'package:flutter/cupertino.dart';

class FeedViewModel extends ChangeNotifier {
  var _currentLocation = 'Delhi';
  var _currentBloodGroup = 'O-';
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

  void changeBloodGroup(String bloodGroup) {
    _currentBloodGroup = bloodGroup;
    notifyListeners();
  }
}
