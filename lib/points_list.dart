import 'package:capstone/point_qrcode.dart';
import 'package:capstone/senior/sraccount.dart';
import 'package:flutter/material.dart';

class PointsListPage extends StatefulWidget {
  const PointsListPage({Key? key}) : super(key: key);

  @override
  State<PointsListPage> createState() => _PointsListPageState();
}

class _PointsListPageState extends State<PointsListPage> {
  void _showPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select this reward?'),
            content: Text('Once chosen, cannot be undone'),
            actions: [
              MaterialButton(
                onPressed: () {},
                child: Text('No'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PointQrPage()),
                  );
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('포인트 상점',
            style: TextStyle(
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold,
                fontSize: 25)), // You can add title here
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 14, 99, 246)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent, //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                _showPopUp(context);
              },
              child: Container(
                margin: EdgeInsets.all(20),
                height: 100,
                width: 360,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 2,
                    ),
                    Icon(Icons.airplane_ticket, size: 38),
                    SizedBox(
                      width: 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Point title', style: TextStyle(fontSize: 30)),
                        Text('100 points'),
                      ],
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(Icons.arrow_right_sharp, size: 35),
                    SizedBox(
                      width: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
