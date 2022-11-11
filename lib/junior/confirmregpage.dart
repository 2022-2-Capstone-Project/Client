import 'package:capstone/junior/tourpage.dart';
import 'package:flutter/material.dart';

class ConfirmRegPage extends StatefulWidget {
  const ConfirmRegPage({Key? key}) : super(key: key);

  @override
  State<ConfirmRegPage> createState() => _ConfirmRegPageState();
}

class _ConfirmRegPageState extends State<ConfirmRegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Text('신청 완료',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey)),
            SizedBox(height: 30),
            Icon(
              Icons.check_circle_outline,
              size: 200,
              color: Colors.green,
            ),

            //기본 정보 (to be updated)

            SizedBox(height: 230),

            //button for 확인 & 채팅
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 14, 99, 246),
                      ),
                      child: Center(
                        child: Text('채팅',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TourPage(),
                              ),
                            );
                          },
                          child: Text('확인',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
