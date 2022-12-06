import 'package:capstone/senior/tourgoingon.dart';
import 'package:flutter/material.dart';

class RegisterTourPage extends StatefulWidget {
  const RegisterTourPage({Key? key}) : super(key: key);

  @override
  State<RegisterTourPage> createState() => _RegisterTourPageState();
}

class _RegisterTourPageState extends State<RegisterTourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내가 신청한 투어',
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
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        height: 150,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 50,
              ),
              SingleChildScrollView(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TourGoingOn()),
                    );
                  },
                  child: Center(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text('Tour title',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 20,
                            ),
                            new Text('created date',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          size: 70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
