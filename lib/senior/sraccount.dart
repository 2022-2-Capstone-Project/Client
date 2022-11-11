import 'package:capstone/senior/themeswrote.dart';
import 'package:capstone/senior/tourwrote.dart';
import 'package:flutter/material.dart';

class SeniorAccountPage extends StatefulWidget {
  const SeniorAccountPage({Key? key}) : super(key: key);

  @override
  State<SeniorAccountPage> createState() => _SeniorAccountPageState();
}

class _SeniorAccountPageState extends State<SeniorAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('계정',
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 50),
        child: Container(
          child: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: CircleAvatar(
                          backgroundColor: Colors.pinkAccent.shade100,
                          child: Text('AS',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black)),
                          radius: 35),
                    ),
                    SizedBox(height: 10),
                    Text('Syaffa',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThemesWrotePage(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.article, size: 35),
                        title:
                            Text('내가 쓴 테마 목록', style: TextStyle(fontSize: 20)),
                        trailing: Icon(Icons.arrow_right_sharp, size: 35),
                        iconColor: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TourWrotePage(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.article, size: 35),
                        title: Text('내가 만든 투어', style: TextStyle(fontSize: 20)),
                        trailing: Icon(Icons.arrow_right_sharp, size: 35),
                        iconColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
