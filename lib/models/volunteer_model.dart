import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerModel {
  final volunteerId;
  final name;
  final location;
  // final city;
  final bloodGroup;
  final covidMonth;
  final phoneNumber;
  final isPaused;

  VolunteerModel({
    //this.city,
    this.volunteerId,
    this.name,
    this.location,
    this.bloodGroup,
    this.covidMonth,
    this.phoneNumber,
    this.isPaused,
  });

  Map<String, dynamic> toMap() {
    return {
      "volunteerId": volunteerId,
      "name": name,
      //"city": city,
      "bloodGroup": bloodGroup,
      "location": location,
      "covidMonth": covidMonth,
      "phoneNumber": phoneNumber,
      "isPaused": isPaused,
    };
  }

  factory VolunteerModel.fromQuerySnapshot(
      QueryDocumentSnapshot querySnapshot) {
    final bloodGroup = querySnapshot['bloodGroup'];
    final volunteerId = querySnapshot['volunteerId'];
    final name = querySnapshot['name'];
    final location = querySnapshot['location'];
    //final city = querySnapshot['city'];
    final covidMonth = querySnapshot['covidMonth'];
    final phoneNumber = querySnapshot['phoneNumber'];
    final isPaused = querySnapshot['isPaused'];
    return VolunteerModel(
      volunteerId: volunteerId,
      // city: city,
      name: name,
      location: location,
      covidMonth: covidMonth,
      phoneNumber: phoneNumber,
      bloodGroup: bloodGroup,
      isPaused: isPaused,
    );
  }
}
