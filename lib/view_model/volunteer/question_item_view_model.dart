import 'package:covid_care/models/questions.dart';
import 'package:flutter/cupertino.dart';

class QuestionItemViewModel extends ChangeNotifier {
  final Question question;
  QuestionItemViewModel(this.question);

  void mark(bool isSelected) {
    question.isSelected = isSelected;
    notifyListeners();
  }
}
