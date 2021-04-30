import 'package:covid_care/routes/custom_route.dart';
import 'package:covid_care/routes/route_constants.dart';
import 'package:covid_care/screens/feed/feed.dart';
import 'package:covid_care/screens/home/home_screen.dart';
import 'package:covid_care/screens/login/login_screen.dart';
import 'package:covid_care/screens/volunteer/register_volunteer/checklist_page.dart';
import 'package:covid_care/screens/volunteer/register_volunteer/register_page.dart';
import 'package:covid_care/view_model/feed/feed_list_view_model.dart';
import 'package:covid_care/view_model/feed/feed_view_model.dart';
import 'package:covid_care/view_model/volunteer/blood_group_view_model.dart';
import 'package:covid_care/view_model/volunteer/location_dropdown_view_model.dart';
import 'package:covid_care/view_model/volunteer/question_item_view_model.dart';
import 'package:covid_care/view_model/volunteer/questions_view_model.dart';
import 'package:covid_care/view_model/volunteer/register_view_model.dart';
import 'package:covid_care/view_model/volunteer/volunteer_feed/volunteer_feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  // static dynamic route() {
  //   return {
  //     splash: (BuildContext context) => SplashScreen(),
  //   };
  // }

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return CustomRoute<bool>(
            builder: (BuildContext context) => LoginScreen());
      case RouteNames.home:
        return CustomRoute<bool>(
            builder: (BuildContext context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<StateDropdownViewModel>(
                      create: (context) => StateDropdownViewModel(),
                    ),
                    ChangeNotifierProvider<BloodGroupDropdownViewModel>(
                      create: (context) => BloodGroupDropdownViewModel(),
                    ),
                    ChangeNotifierProvider<FeedViewModel>(
                      create: (context) => FeedViewModel(),
                    ),
                    ChangeNotifierProvider<VolunteerFeedViewModel>(
                      create: (context) => VolunteerFeedViewModel(),
                    ),
                  ],
                  child: HomeScreen(),
                ));
      case RouteNames.plasmaVolunteerRegister:
        return CustomRoute<bool>(
            builder: (BuildContext context) => ChangeNotifierProvider(
                create: (context) => QuestionsViewModel(),
                child: PlasmaVolunteerRegisterScreen()));
      case RouteNames.registerToFirebase:
        return CustomRoute<bool>(
            builder: (BuildContext context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<StateDropdownViewModel>(
                      create: (context) => StateDropdownViewModel(),
                    ),
                    ChangeNotifierProvider<BloodGroupDropdownViewModel>(
                      create: (context) => BloodGroupDropdownViewModel(),
                    ),
                    ChangeNotifierProvider<RegisterVolunteerViewModel>(
                      create: (context) => RegisterVolunteerViewModel(),
                    ),
                  ],
                  child: RegisterPage(),
                ));
      default:
        return onUnknownRoute(RouteSettings(name: '/invalid'));
    }
  }

  static Route onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(settings.name.split('/')[1]),
          centerTitle: true,
        ),
        body: Center(
          child: Text('${settings.name} Comming soon..'),
        ),
      ),
    );
  }
}
