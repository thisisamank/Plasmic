import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final name;
  Location(this.name);

  factory Location.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return Location(snapshot['name']);
  }
}
