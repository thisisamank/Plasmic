import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/view_model/volunteer/dropdown_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownMenu<T extends DropdownViewModel> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (
        context,
        T dropdownViewModel,
        child,
      ) {
        return StreamBuilder<QuerySnapshot>(
            stream: dropdownViewModel.dropdownItemsAsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                dropdownViewModel.fromSnapshot(snapshot.data);
                return DropdownButton<String>(
                  hint: Text(
                    "Not selected",
                  ),
                  value: dropdownViewModel.selectedItem,
                  onChanged: (final String newValue) {
                    dropdownViewModel.setSelected(newValue);
                  },
                  items:
                      dropdownViewModel.location.map<DropdownMenuItem<String>>(
                    (final value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      );
                    },
                  ).toList(),
                );
              } else
                return CircularProgressIndicator(
                  backgroundColor: BrandColors.blue,
                );
            });
      },
    );
  }
}
