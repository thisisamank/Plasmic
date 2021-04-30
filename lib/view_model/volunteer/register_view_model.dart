import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterVolunteerViewModel extends ChangeNotifier {
  var name;
  var location;
  var bloodGroup;
  var covidMonth;
  var phoneNumber;

  void saveVolunteer() async {
    VolunteerModel volunteerModel = VolunteerModel(
      volunteerId: FirebaseAuth.instance.currentUser.uid,
      name: name,
      bloodGroup: bloodGroup,
      covidMonth: covidMonth,
      phoneNumber: phoneNumber,
      location: location,
      isPaused: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({'empty-data': 'data'});
    final docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('volunteers')
        .add(volunteerModel.toMap());

    FirebaseFirestore.instance
        .collection('plasma')
        .doc(location)
        .collection(location)
        .doc(docRef.id)
        .set(volunteerModel.toMap());
    FirebaseFirestore.instance
        .collection('plasma')
        .doc(location)
        .set({'empty-data': 'data'});
    notifyListeners();
  }
}
