import 'dart:math';

import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/view_model/volunteer/blood_group_view_model.dart';
import 'package:covid_care/view_model/volunteer/location_dropdown_view_model.dart';
import 'package:covid_care/view_model/volunteer/register_view_model.dart';
import 'package:covid_care/widgets/dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _covidMonthController = TextEditingController();

  RegisterVolunteerViewModel _registerViewModel;
  StateDropdownViewModel _locationsDropdownViewModel;
  BloodGroupDropdownViewModel _bloodGroupDropdownViewModel;

  @override
  Widget build(BuildContext context) {
    _registerViewModel = Provider.of<RegisterVolunteerViewModel>(context);
    _locationsDropdownViewModel =
        Provider.of<StateDropdownViewModel>(context);
    _bloodGroupDropdownViewModel =
        Provider.of<BloodGroupDropdownViewModel>(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        height: 1000,
        width: 400,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) => _registerViewModel.name = value,
                validator: _stringValidator,
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Volunteer\'s Name',
                  border: OutlineInputBorder(gapPadding: 0),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                onChanged: (value) => _registerViewModel.covidMonth = value,
                validator: _stringValidator,
                controller: _covidMonthController,
                decoration: InputDecoration(
                  hintText: 'In which month covid happend to you?',
                  border: OutlineInputBorder(gapPadding: 0),
                ),
              ),
              Row(
                children: [
                  Text("State", style: textTheme.bodyText2),
                  SizedBox(width: 25),
                  DropdownMenu<StateDropdownViewModel>(),
                ],
              ),
              Row(
                children: [
                  Text("Blood Group", style: textTheme.bodyText2),
                  SizedBox(width: 25),
                  DropdownMenu<BloodGroupDropdownViewModel>(),
                ],
              ),
              TextFormField(
                onChanged: (value) => _registerViewModel.phoneNumber = value,
                controller: _phoneController,
                keyboardType: TextInputType.number,
                validator: _phoneValidator,
                decoration: InputDecoration(
                  hintText: 'Your contact number?',
                  border: OutlineInputBorder(gapPadding: 0),
                ),
              ),
              MaterialButton(
                onPressed: () => _registerVolunteer(context),
                child: Text("Register"),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _stringValidator(String value) {
    if (value.isEmpty) return "Please Enter your details";
  }

  String _phoneValidator(String value) {
    if (value.length != 10 || value == null)
      return "Please Enter correct contact number";
  }

  _registerVolunteer(context) {
    if (!(_formKey.currentState.validate() &&
        _locationsDropdownViewModel.isSelected &&
        _bloodGroupDropdownViewModel.isSelected)) {
      Toast.show("Fill the details correctly", context);
    } else {
      _registerViewModel.bloodGroup = _bloodGroupDropdownViewModel.selectedItem;
      _registerViewModel.location = _locationsDropdownViewModel.selectedItem;
      _registerViewModel.saveVolunteer();
    }
  }
}
