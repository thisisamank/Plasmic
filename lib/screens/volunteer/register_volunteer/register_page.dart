import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/routes/route_constants.dart';
import 'package:covid_care/view_model/volunteer/blood_group_view_model.dart';
import 'package:covid_care/view_model/volunteer/location_dropdown_view_model.dart';
import 'package:covid_care/view_model/volunteer/month_view_model.dart';
import 'package:covid_care/view_model/volunteer/register_view_model.dart';
import 'package:covid_care/view_model/volunteer/year_view_model.dart';
import 'package:covid_care/widgets/dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  RegisterVolunteerViewModel _registerViewModel;
  StateDropdownViewModel _locationsDropdownViewModel;
  BloodGroupDropdownViewModel _bloodGroupDropdownViewModel;
  MonthDropdownViewModel _monthDropdownViewModel;
  YearDropdownViewModel _yearDropdownViewModel;

  @override
  Widget build(BuildContext context) {
    _registerViewModel = Provider.of<RegisterVolunteerViewModel>(context);
    _locationsDropdownViewModel = Provider.of<StateDropdownViewModel>(context);
    _monthDropdownViewModel = Provider.of<MonthDropdownViewModel>(context);
    _yearDropdownViewModel = Provider.of<YearDropdownViewModel>(context);
    _bloodGroupDropdownViewModel =
        Provider.of<BloodGroupDropdownViewModel>(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Register Form',
          style: TextStyle(color: BrandColors.black),
        ),
        backgroundColor: BrandColors.white,
        iconTheme: IconThemeData(color: BrandColors.black),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: 400,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text("Volunteer's Name",
                    style: textTheme.bodyText1.copyWith(fontSize: 18)),
                SizedBox(height: 8),
                TextFormField(
                  onChanged: (value) => _registerViewModel.name = value,
                  validator: _stringValidator,
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Volunteer\'s Name',
                    border: OutlineInputBorder(gapPadding: 0),
                  ),
                ),
                SizedBox(height: 24),
                Text("Contact Number",
                    style: textTheme.bodyText1.copyWith(fontSize: 18)),
                SizedBox(height: 8),
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
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("State", style: textTheme.bodyText2),
                    SizedBox(width: 25),
                    DropdownMenu<StateDropdownViewModel>(),
                  ],
                ),
                //TODO: Add city field
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Blood Group", style: textTheme.bodyText2),
                    SizedBox(width: 25),
                    DropdownMenu<BloodGroupDropdownViewModel>(),
                  ],
                ),
                SizedBox(height: 8),
                Text("When did you recover from Covid 19?",
                    style: textTheme.bodyText1.copyWith(fontSize: 18)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Month", style: textTheme.bodyText2),
                    SizedBox(width: 25),
                    DropdownMenu<MonthDropdownViewModel>(),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Year", style: textTheme.bodyText2),
                    SizedBox(width: 25),
                    DropdownMenu<YearDropdownViewModel>(),
                  ],
                ),
                SizedBox(height: 48),
                Center(
                  child: MaterialButton(
                    minWidth: 150,
                    height: 40,
                    color: BrandColors.blue,
                    textColor: BrandColors.white,
                    onPressed: () => _registerVolunteer(context),
                    child: Text("Register"),
                  ),
                )
              ],
            ),
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
        _bloodGroupDropdownViewModel.isSelected &&
        _monthDropdownViewModel.isSelected &&
        _yearDropdownViewModel.isSelected)) {
      Toast.show("Fill the details correctly 😌", context);
    } else {
      _registerViewModel.covidMonth =
          '${_monthDropdownViewModel.selectedItem}, ${_yearDropdownViewModel.selectedItem}';
      _registerViewModel.bloodGroup = _bloodGroupDropdownViewModel.selectedItem;
      _registerViewModel.location = _locationsDropdownViewModel.selectedItem;
      _registerViewModel.saveVolunteer();
      Toast.show("Volunteer Saved 🙏", context);

      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.home, (route) => false);
    }
  }
}
