import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/routes/route_constants.dart';
import 'package:covid_care/view_model/volunteer/questions_view_model.dart';
import 'package:covid_care/widgets/questions_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlasmaVolunteerRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Terms and Conditions',
          style: TextStyle(color: BrandColors.black),
        ),
        backgroundColor: BrandColors.white,
        iconTheme: IconThemeData(color: BrandColors.black),
      ),
      body: Consumer(
        builder: (context, QuestionsViewModel questionsViewModel, child) =>
            Container(
          height: size.height,
          width: 400,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...questionsViewModel.questions
                    .map((item) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: QuestionWidget(
                            questionItemsViewModel: item,
                            onChanged: (selected) {
                              questionsViewModel.markQuestion(item, selected);
                            },
                          ),
                        ))
                    .toList(),
                SizedBox(height: 16),
                Text(
                  questionsViewModel.message,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: BrandColors.red, fontSize: 14),
                ),
                SizedBox(height: 16),
                MaterialButton(
                  onPressed: () {
                    if (questionsViewModel.isAllSelected) {
                      _validateAndNavigateToFormFilling(context);
                    }
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(color: BrandColors.white),
                  ),
                  minWidth: 100,
                  height: 40,
                  color: BrandColors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateAndNavigateToFormFilling(context) {
    Navigator.of(context).pushNamed(RouteNames.registerToFirebase);
  }
}
