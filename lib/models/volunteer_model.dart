import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerModel {
  final volunteerId;
  final name;
  final location;
  final city;
  final bloodGroup;
  final covidMonth;
  final phoneNumber;
  final isPaused;
  var calledTimes = 0;

  VolunteerModel({
    this.city,
    this.volunteerId,
    this.name,
    this.location,
    this.bloodGroup,
    this.covidMonth,
    this.phoneNumber,
    this.isPaused,
    this.calledTimes,
  });

  Map<String, dynamic> toMap() {
    return {
      "volunteerId": volunteerId,
      "name": name,
      "calledTimes": calledTimes,
      "city": city,
      "bloodGroup": bloodGroup,
      "location": location,
      "covidMonth": covidMonth,
      "phoneNumber": phoneNumber,
      "isPaused": isPaused,
    };
  }

  factory VolunteerModel.fromQuerySnapshot(
      QueryDocumentSnapshot querySnapshot) {
    var city = null;
    final bloodGroup = querySnapshot['bloodGroup'];
    final volunteerId = querySnapshot['volunteerId'];
    final calledTimes = querySnapshot['calledTimes'];
    final name = querySnapshot['name'];
    final location = querySnapshot['location'];
    //TODO: will be changed with new data
    try {
      city = querySnapshot['city'];
    } catch (e) {
      city = 'Unknown';
    }
    final covidMonth = querySnapshot['covidMonth'];
    final phoneNumber = querySnapshot['phoneNumber'];
    final isPaused = querySnapshot['isPaused'];
    return VolunteerModel(
      volunteerId: volunteerId,
      calledTimes: calledTimes,
      city: city,
      name: name,
      location: location,
      covidMonth: covidMonth,
      phoneNumber: phoneNumber,
      bloodGroup: bloodGroup,
      isPaused: isPaused,
    );
  }
}
