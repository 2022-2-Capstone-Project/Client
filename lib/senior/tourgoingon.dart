import 'package:flutter/material.dart';

class TourGoingOn extends StatefulWidget {
  const TourGoingOn({super.key});

  @override
  State<TourGoingOn> createState() => _TourGoingOnState();
}

class _TourGoingOnState extends State<TourGoingOn> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 14, 99, 246)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Tour title',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    'Theme description',
                    style: TextStyle(fontSize: 15),
                  ))),
              SizedBox(
                height: 40,
              ),
              Text(
                'Map : ',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 40),
              Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Text("1/4 Participants",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blueAccent,
                child: Text("투어 시작",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
