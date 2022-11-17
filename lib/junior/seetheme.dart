import 'package:capstone/senior/makethemepage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SeeThemePage extends StatefulWidget {
  @override
  _SeeThemePageState createState() => _SeeThemePageState();
}

class _SeeThemePageState extends State<SeeThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('테마 목록',
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 14, 99, 246),
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
