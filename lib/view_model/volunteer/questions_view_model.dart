import 'package:covid_care/models/questions.dart';
import 'package:covid_care/view_model/volunteer/question_item_view_model.dart';
import 'package:flutter/cupertino.dart';

class QuestionsViewModel extends ChangeNotifier {
  String message = "";
  List<QuestionItemViewModel> _questions = [
    QuestionItemViewModel(
      Question(
          "I was a COVID Positive patient and, I have been cured for 14 days.",
          false),
    ),
    QuestionItemViewModel(Question("I am negative now.", false)),
    QuestionItemViewModel(Question("I am between 18-60 years.", false)),
    QuestionItemViewModel(Question("I do not weigh less than 50kg.", false)),
    QuestionItemViewModel(Question("I have never been pregnant.", false)),
    QuestionItemViewModel(Question("I am not a diabetic person.", false)),
    QuestionItemViewModel(Question(
        "My blood pressure not more than 140 and diastolic less than 60 or more than 90.",
        false)),
    QuestionItemViewModel(Question(
        "I do not have any other chronic disease with change in medication in last 28 days.",
        false)),
    QuestionItemViewModel(
        Question("I agree to donate plasma with my own concern.", false)),
  ];

  void markQuestion(QuestionItemViewModel question, bool isSelected) {
    question.mark(isSelected);
    isAllSelected;
    notifyListeners();
  }

  List<QuestionItemViewModel> get questions => _questions;

  bool get isAllSelected {
    bool result = _questions
            .where((element) => element.question.isSelected)
            .toList()
            .length ==
        _questions.length;
    if (result)
      message = "";
    else
      message = "You can only proceed if you agree to above";
    notifyListeners();
    return result;
  }
}
