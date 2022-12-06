import 'package:capstone/points_list.dart';
import 'package:capstone/senior/navigation_bar.dart';
import 'package:flutter/material.dart';

class PointQrPage extends StatefulWidget {
  const PointQrPage({Key? key}) : super(key: key);

  @override
  State<PointQrPage> createState() => _PointQrPageState();
}

class _PointQrPageState extends State<PointQrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('발급 완료',
            style: TextStyle(
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold,
                fontSize: 25)), // You can add title here
        leading: IconButton(
          icon: Icon(Icons.close, color: Color.fromARGB(255, 14, 99, 246)),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBar()),
            ),
          },
        ),
        backgroundColor: Colors.transparent, //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Selected Reward',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Random unique ID code',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '학생회에 제출해주세요!',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            margin: EdgeInsets.all(40),
            height: 400,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          Text('QrCode', style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
