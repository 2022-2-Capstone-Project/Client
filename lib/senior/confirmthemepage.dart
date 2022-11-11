import 'package:flutter/material.dart';

class ConfirmThemePage extends StatefulWidget {
  const ConfirmThemePage({Key? key}) : super(key: key);

  @override
  State<ConfirmThemePage> createState() => _ConfirmThemePageState();
}

class _ConfirmThemePageState extends State<ConfirmThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            Text('테마 만들기 완료',
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
