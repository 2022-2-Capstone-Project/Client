import 'package:flutter/material.dart';
import 'package:capstone/junior/tourdetails.dart';

class TourPage extends StatefulWidget {
  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('투어 목록',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold)),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            height: 150,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
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
                  backgroundColor: Colors.blue,
                ),
                SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TourDetails(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Text('-학교-',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16)),
                        new Text('정문에서 후문까지 편하게 가는 법!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        new Text('화, 15:00~',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16)),
                        new Text(
                          '10분전',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
