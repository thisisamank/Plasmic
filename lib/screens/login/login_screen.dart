import 'package:covid_care/models/user_model.dart';
import 'package:covid_care/routes/route_constants.dart';
import 'package:covid_care/view_model/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginViewModel _loginViewModel;
  @override
  Widget build(BuildContext context) {
    _loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final user = await _loginViewModel.login();
          if (user) {
            Navigator.pushReplacementNamed(context, RouteNames.home);
          }
        },
      ),
      body: Container(
        child: Center(child: Text("Login screen")),
      ),
    );
  }
}
