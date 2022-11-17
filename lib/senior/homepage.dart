import 'package:capstone/senior/makethemepage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
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
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "make theme",
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MakeThemePage(),
              ));
        },
        label: const Text('테마 만들기'),
        icon: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 14, 99, 246),
      ),
    );
  }
}
