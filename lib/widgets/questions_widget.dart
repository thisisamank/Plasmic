import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/view_model/volunteer/question_item_view_model.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final QuestionItemViewModel questionItemsViewModel;
  final onChanged;

  QuestionWidget({this.questionItemsViewModel, this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * .7,
          child: Text(
            questionItemsViewModel.question.title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Checkbox(
          activeColor: BrandColors.blue,
          checkColor: BrandColors.white,
          value: questionItemsViewModel.question.isSelected,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
