import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/routes/route_constants.dart';
import 'package:covid_care/view_model/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginViewModel _loginViewModel;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _loginViewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LET'S FIGHT",
                    style: GoogleFonts.bebasNeue(fontSize: 48),
                  ),
                  Text(
                    "Corona",
                    style: GoogleFonts.bebasNeue(
                        fontSize: 48, color: BrandColors.blue),
                  ),
                  Text(
                    "Together",
                    style: GoogleFonts.bebasNeue(fontSize: 48),
                  ),
                ],
              ),
              Image.asset(
                'images/login-image.png',
                width: 300,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
                ),
                onPressed: () async {
                  final user = await _loginViewModel.login();
                  if (user) {
                    Navigator.pushReplacementNamed(context, RouteNames.home);
                  }
                },
                icon: SvgPicture.asset('images/google.svg'),
                label: Text("Login with Google"),
              ),
              Text(_loginViewModel.message)
            ],
          ),
        ),
      ),
    );
  }
}
