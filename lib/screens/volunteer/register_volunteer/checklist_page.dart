import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/routes/route_constants.dart';
import 'package:covid_care/view_model/volunteer/questions_view_model.dart';
import 'package:covid_care/widgets/questions_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PlasmaVolunteerRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColors.white,
        iconTheme: IconThemeData(color: BrandColors.black),
        elevation: 0,
      ),
      body: Consumer(
        builder: (context, QuestionsViewModel questionsViewModel, child) =>
            Container(
          height: 1000,
          width: 400,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ...questionsViewModel.questions
                  .map((item) => QuestionWidget(
                        questionItemsViewModel: item,
                        onChanged: (selected) {
                          questionsViewModel.markQuestion(item, selected);
                        },
                      ))
                  .toList(),
              SizedBox(height: 28),
              MaterialButton(
                onPressed: () {
                  if (questionsViewModel.isAllSelected) {
                    _validateAndNavigateToFormFilling(context);
                  } else {
                    Toast.show("You can only", context);
                  }
                },
                child: Text(
                  "Proceed ->",
                  style: TextStyle(color: BrandColors.white),
                ),
                minWidth: 150,
                color: BrandColors.blue,
              ),
              Text(
                questionsViewModel.message,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateAndNavigateToFormFilling(context) {
    Navigator.of(context).pushNamed(RouteNames.registerToFirebase);
  }
}
