import 'package:capstone/log_in.dart';
import 'package:flutter/material.dart';

class NotLogInPage extends StatefulWidget {
  const NotLogInPage({Key? key}) : super(key: key);

  @override
  State<NotLogInPage> createState() => _NotLogInPageState();
}

class _NotLogInPageState extends State<NotLogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInPage(),
                ),
              );
            },
            child: ListTile(
              leading: Icon(Icons.account_box, size: 50),
              title: Text('로그인하세요', style: TextStyle(fontSize: 28)),
              trailing: Icon(Icons.arrow_right_sharp, size: 40),
              iconColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
