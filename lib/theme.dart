import 'package:capstoneproject/themedetails.dart';
import 'package:flutter/material.dart';

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
        title: const Text('테마 목록',style: TextStyle(fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon : Icon(
              Icons.search,
              color: Colors.blueAccent,
              size: 30,
            ),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            height: 150,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0,3),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: new AssetImage('/Users/syaffa255/StudioProjects/capstoneproject/lib/cau.jpeg'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text('-학교-', textAlign: TextAlign.center, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    new Text('    예상 소요 시간 : 2시간', textAlign:TextAlign.center, style: TextStyle(fontSize: 16)),
                    new Text('장소 : 중앙대학교 정문', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThemeDetails(),
              ),
            );
          },
          ),

      ),
    );
  }
}