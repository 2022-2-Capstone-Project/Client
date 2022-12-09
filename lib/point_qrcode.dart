import 'package:capstone/points_list.dart';
import 'package:capstone/senior/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PointQrPage extends StatefulWidget {
  const PointQrPage({Key? key}) : super(key: key);

  @override
  State<PointQrPage> createState() => _PointQrPageState();
}

class _PointQrPageState extends State<PointQrPage> {
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    var v4 = uuid.v4();
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
            '학생회에 제출해주세요!',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Text(
                'ID code :',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '          ${v4}',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'QR CODE : ',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          QrImage(
            data: "1234567890",
            version: QrVersions.auto,
            size: 300.0,
          ),
          //Center(child: Image(image: AssetImage('images/qr_code_barcode.jpg'))),
        ],
      ),
    );
  }
}
