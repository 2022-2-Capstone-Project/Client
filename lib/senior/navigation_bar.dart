import 'package:capstone/junior/tourpage.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:capstone/senior/homepage.dart';
import 'package:capstone/senior/sraccount.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final items = [
    if (LocationController.get.userId == null)
      Icon(Icons.tour_outlined, size: 30)
    else
      Icon(Icons.tour, size: 30),
    Icon(Icons.home, size: 30),
    Icon(Icons.person, size: 30),
  ];
  int index = 1;
  @override
  Widget build(BuildContext context) {
    Future<void> getProfile() async {}

    getProfile();

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: Colors.blueAccent,
          items: items,
          index: index,
          onTap: (selectedIndex) {
            setState(() {
              index = selectedIndex;
            });
          },
          animationDuration: const Duration(milliseconds: 300),
        ),
        body: Container(
          child: getSelectedWidget(index: index),
        ),
      ),
    );
  }
}

Widget getSelectedWidget({required int index}) {
  Widget widget;
  switch (index) {
    case 0:
      widget = TourPage();
      break;
    case 1:
      widget = ThemePage();
      break;
    case 2:
      widget = SeniorAccountPage();
      break;
    default:
      widget = ThemePage();
      break;
  }
  return widget;
}
