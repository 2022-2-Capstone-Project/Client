import 'package:flutter/material.dart';
import 'package:capstoneproject/homepage.dart';
import 'package:capstoneproject/theme.dart';
import 'package:capstoneproject/account.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBar()
    ),
  );
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  final items = const [
    Icon(Icons.home, size: 30),
    Icon(Icons.airplay, size: 30),
    Icon(Icons.person, size: 30),
  ];
  int index = 1;
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color : Colors.white,
          backgroundColor: Colors.blueAccent,
          items: items,
          index : index,
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
  switch(index){
    case 0:
      widget = HomePage();
      break;
    case 1:
      widget = ThemePage();
      break;
    case 2:
      widget = Account();
      break;
    default:
      widget = HomePage();
      break;
  }
  return widget;
}



