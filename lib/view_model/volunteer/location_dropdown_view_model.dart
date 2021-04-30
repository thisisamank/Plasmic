import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/view_model/volunteer/dropdown_view_model.dart';
import 'package:flutter/cupertino.dart';

class StateDropdownViewModel extends DropdownViewModel with ChangeNotifier {
  @override
  String get selectedItem => super.selected;

  @override
  void setSelected(String selected) {
    super.selected = selected;
    notifyListeners();
  }

  bool get isSelected => selectedItem != null;

  @override
  Stream get dropdownItemsAsStream =>
      FirebaseFirestore.instance.collection('states').snapshots();

  @override
  fromSnapshot(QuerySnapshot documentSnapshot) {
    location = documentSnapshot.docs.map((item) => item['name']).toList();
  }
}
