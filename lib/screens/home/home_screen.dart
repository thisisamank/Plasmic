import 'package:covid_care/constants/colors.dart';
import 'package:covid_care/screens/feed/feed.dart';
import 'package:covid_care/screens/guidelines/guidelines.dart';
import 'package:covid_care/screens/volunteer/volunteer_feed/volunteer_feed.dart';
import 'package:covid_care/view_model/feed/feed_view_model.dart';
import 'package:covid_care/view_model/volunteer/blood_group_view_model.dart';
import 'package:covid_care/view_model/volunteer/location_dropdown_view_model.dart';
import 'package:covid_care/widgets/dropdown_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_care/screens/volunteer/register_volunteer/volunteer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FeedViewModel _feedViewModel;
  StateDropdownViewModel _stateDropdownViewModel;
  BloodGroupDropdownViewModel _bloodGroupDropdownViewModel;
  int _currentIndex = 0;
  _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _pages = [
    FeedPage(),
    VolunteerPage(),
    GuidelinesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    _feedViewModel = Provider.of<FeedViewModel>(context);
    _stateDropdownViewModel =
        Provider.of<StateDropdownViewModel>(context, listen: false);
    _bloodGroupDropdownViewModel =
        Provider.of<BloodGroupDropdownViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plasmic',
          style: TextStyle(
            color: BrandColors.blue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: BrandColors.white,
        actions: [
          IconButton(
              tooltip: 'Filter',
              icon: SvgPicture.asset('images/filter.svg'),
              onPressed: () => showHomeBottomSheet(context))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('images/home.svg'),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/volunteer.svg',
              color: Colors.black,
            ),
            label: 'Volunteer',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/guidelines.svg',
              color: Colors.black,
            ),
            label: 'Guidelines',
          ),
        ],
        onTap: _onTap,
        currentIndex: _currentIndex,
      ),
      body: _pages[_currentIndex],
    );
  }

  showHomeBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          var textTheme = Theme.of(context).textTheme;
          return ChangeNotifierProvider.value(
            value: _bloodGroupDropdownViewModel,
            child: ChangeNotifierProvider.value(
              value: _stateDropdownViewModel,
              child: Container(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 6),
                      Text(
                        "Filter",
                        style: textTheme.bodyText2
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("State", style: textTheme.bodyText2),
                          SizedBox(width: 25),
                          DropdownMenu<StateDropdownViewModel>(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Blood Group", style: textTheme.bodyText2),
                          SizedBox(width: 25),
                          DropdownMenu<BloodGroupDropdownViewModel>(),
                        ],
                      ),
                      SizedBox(height: 16),
                      MaterialButton(
                        onPressed: () {
                          final bloodGroup =
                              _bloodGroupDropdownViewModel.selectedItem;
                          final location = _stateDropdownViewModel.selectedItem;
                          print(bloodGroup);
                          if (bloodGroup != null && location != null) {
                            _feedViewModel.changeBloodGroup(bloodGroup);
                            _feedViewModel.changeLocation(location);
                            Navigator.pop(context);
                          }
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                        color: BrandColors.blue,
                        textColor: BrandColors.white,
                        child: Text("Apply Filter"),
                      ),
                      SizedBox(height: 16),
                    ],
                  )),
            ),
          );
        });
  }
}
