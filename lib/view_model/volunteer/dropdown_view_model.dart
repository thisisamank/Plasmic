import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DropdownViewModel {
  List<dynamic> location;
  String selected;
  void setSelected(String selected);
  get selectedItem;
  Stream get dropdownItemsAsStream;
  dynamic fromSnapshot(QuerySnapshot documentSnapshot);
}
