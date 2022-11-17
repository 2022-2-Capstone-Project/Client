import 'package:capstone/chatpage.dart';
import 'package:capstone/junior/jrtourgoingon.dart';
import 'package:capstone/junior/seetheme.dart';
import 'package:capstone/senior/homepage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:capstone/junior/tourpage.dart';
import 'package:capstone/junior/jraccount.dart';

class NavBarJr extends StatefulWidget {
  const NavBarJr({Key? key}) : super(key: key);

  @override
  State<NavBarJr> createState() => _NavBarJrState();
}

class _NavBarJrState extends State<NavBarJr> {
  final items = const [
    Icon(Icons.tour, size: 30),
    Icon(Icons.home, size: 30),
    Icon(Icons.brush, size: 30),
    Icon(Icons.person, size: 30),
  ];
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

Widget getSelectedWidget({required int index}) {
  Widget widget;
  switch (index) {
    case 0:
      widget = JrTourGoingOn();
      break;
    case 1:
      widget = TourPage();
      break;
    case 2:
      widget = SeeThemePage();
      break;
    case 3:
      widget = JuniorAccountPage();
      break;
    default:
      widget = TourPage();
      break;
  }
  return widget;
}
