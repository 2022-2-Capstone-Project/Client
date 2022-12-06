import 'package:capstone/junior/confirmregpage.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourDetails extends StatefulWidget {
  @override
  _TourDetailsState createState() => _TourDetailsState();
}

class _TourDetailsState extends State<TourDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('투어',
            style: TextStyle(
                fontSize: 30,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 60,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.account_circle),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text('nickname'),
                            Text('followers'),
                          ],
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        Row(
                          children: [Text('rating'), Text(" 점")],
                        )
                      ],
                    ),
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  )),
            ),
            pinned: true,
            backgroundColor: Color.fromARGB(255, 14, 99, 246),
            expandedHeight: 300,
          ),
          SliverToBoxAdapter(
              child: Text(
            'Tour title',
            textAlign: TextAlign.center,
            style:
                TextStyle(height: 2, fontSize: 30, fontWeight: FontWeight.bold),
          )),
          SliverToBoxAdapter(
              child: Text(
            'Tour theme',
            textAlign: TextAlign.center,
            style:
                TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
          )),
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'uploaded date',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 2, fontSize: 15),
                ),
                Text(
                  'date, time',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 2, fontSize: 15),
                ),
              ],
            ),
          )),
          SliverToBoxAdapter(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Description:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'description' ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(height: 3, fontSize: 20),
              ),
              Container(
                height: 400,
                width: double.maxFinite,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Start Place: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                        child: Text(
                      'google Map',
                      style: TextStyle(fontSize: 20, height: 3),
                    )),
                  ],
                ),
              ),
            ],
          )),

          // start place (map showing the lat and long of the place)
        ],
      ),
      bottomNavigationBar: LocationController.get.userId == null
          ? null
          : Container(
              height: 56,
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 66,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.favorite, color: Colors.red),
                      ],
                    ),
                  ),
                  Text("1/3 Participants",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.blueAccent,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmRegPage(),
                            ),
                          );
                        },
                        child: Text("신청하기",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
