import 'package:flutter/material.dart';

class JrTourGoingOn extends StatefulWidget {
  const JrTourGoingOn({super.key});

  @override
  State<JrTourGoingOn> createState() => _JrTourGoingOnState();
}

class _JrTourGoingOnState extends State<JrTourGoingOn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('투어 진행',
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
