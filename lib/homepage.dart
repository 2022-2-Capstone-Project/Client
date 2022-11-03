import 'package:flutter/material.dart';
import 'package:capstoneproject/tourdetails.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('투어 목록',
            style: TextStyle(fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.blueAccent,
              size: 30,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body : Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Container (
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            height: 150,
            padding: const EdgeInsets.all(5.0),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: new AssetImage(
                      '/Users/syaffa255/StudioProjects/capstoneproject/lib/puang.jpeg'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text('-학교-', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
                    new Text('정문에서 후문까지 편하게 가는 법!', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    new Text('화, 15:00~', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
                    new Text('10분전', textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16),),
                  ],
                ),
              ],
            ),
          ),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TourDetails()),
            );
          },
        ),


      ),
    );



  }
}