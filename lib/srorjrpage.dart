import 'package:capstone/signuppage.dart';
import 'package:flutter/material.dart';

class SrorJrPage extends StatefulWidget {
  const SrorJrPage({Key? key}) : super(key: key);

  @override
  State<SrorJrPage> createState() => _SrorJrPageState();
}

class _SrorJrPageState extends State<SrorJrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // gradient background
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              new Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title: Text('회원 가입',
                      style: TextStyle(
                          color: Colors.black)), // You can add title here
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor:
                      Colors.transparent, //You can make this transparent
                  elevation: 0.0, //No shadow
                ),
              ),
              SizedBox(height: 200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Color.fromARGB(255, 14, 99, 246))),
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text('선배 회원',
                        style: TextStyle(
                            color: Color.fromARGB(255, 14, 99, 246),
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                  )),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Color.fromARGB(255, 14, 99, 246))),
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text('후배 회원',
                        style: TextStyle(
                            color: Color.fromARGB(255, 14, 99, 246),
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
