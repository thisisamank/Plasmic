import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/models/volunteer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterVolunteerViewModel extends ChangeNotifier {
  var name;
  var city;
  var state;
  var bloodGroup;
  var covidMonth;
  var phoneNumber;

  void saveVolunteer() async {
    VolunteerModel volunteerModel = VolunteerModel(
      volunteerId: FirebaseAuth.instance.currentUser.uid,
      name: name,
      city: city,
      bloodGroup: bloodGroup,
      covidMonth: covidMonth,
      phoneNumber: phoneNumber,
      location: state,
      calledTimes: 0,
      isPaused: false,
    );

    final docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('volunteers')
        .add(volunteerModel.toMap());

    FirebaseFirestore.instance
        .collection('plasma')
        .doc(state)
        .collection(state)
        .doc(docRef.id)
        .set(volunteerModel.toMap());

    FirebaseFirestore.instance
        .collection('plasma')
        .doc(state)
        .set({'empty-data': 'data'});
  }

  Future<bool> isPresent() async {
    var dataLength;
    final data = await FirebaseFirestore.instance
        .collection('plasma')
        .doc(state)
        .collection(state)
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return data.docs.length != 0;
  }
}
