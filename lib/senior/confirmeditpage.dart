import 'package:flutter/material.dart';

class ConfirmEditPage extends StatefulWidget {
  const ConfirmEditPage({Key? key}) : super(key: key);

  @override
  State<ConfirmEditPage> createState() => _ConfirmEditPageState();
}

class _ConfirmEditPageState extends State<ConfirmEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Text('수정 완료',
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

            //button for 확인
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text('확인',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
