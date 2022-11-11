import 'package:flutter/material.dart';

class JuniorAccountPage extends StatefulWidget {
  const JuniorAccountPage({Key? key}) : super(key: key);

  @override
  State<JuniorAccountPage> createState() => _JuniorAccountPageState();
}

class _JuniorAccountPageState extends State<JuniorAccountPage> {
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
                          backgroundColor: Colors.blue,
                          child: Text('NA',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black)),
                          radius: 35),
                    ),
                    SizedBox(height: 10),
                    Text('Allisya',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    SizedBox(height: 50),
                    ListTile(
                      leading: Icon(Icons.article, size: 35),
                      title: Text('내가 신청한 투어', style: TextStyle(fontSize: 20)),
                      trailing: Icon(Icons.arrow_right_sharp, size: 35),
                      iconColor: Colors.black,
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
