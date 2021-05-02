import 'package:covid_care/constants/theme.dart';
import 'package:covid_care/routes/route_constants.dart';
import 'package:covid_care/routes/routes.dart';
import 'package:covid_care/view_model/login/login_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  LoginViewModel _loginViewModel;
  @override
  Widget build(BuildContext context) {
    _loginViewModel = Provider.of<LoginViewModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
      onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
      title: 'Flutter Demo',
      initialRoute: _getInitialRoute(),
      theme: BrandTheme.themeData,
    );
  }

  _getInitialRoute() {
    if (_loginViewModel.user != null)
      return RouteNames.home;
    else
      return RouteNames.login;
  }
}
