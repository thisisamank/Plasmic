import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dropdown_view_model.dart';

class BloodGroupDropdownViewModel extends DropdownViewModel
    with ChangeNotifier {
  @override
  String get selectedItem => super.selected;

  bool get isSelected => selectedItem != null;

  @override
  void setSelected(String selected) {
    super.selected = selected;
    notifyListeners();
  }

  @override
  Stream get dropdownItemsAsStream =>
      FirebaseFirestore.instance.collection('bloodGroups').snapshots();

  @override
  fromSnapshot(QuerySnapshot documentSnapshot) {
    location = documentSnapshot.docs.map((item) => item['group']).toList();
  }
}
