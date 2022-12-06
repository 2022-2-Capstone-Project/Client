import 'package:capstone/api_manager.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/tourgoingon.dart';
import 'package:flutter/material.dart';
import 'package:capstone/junior/tourdetails.dart';

import '../tour_model.dart';

class TourPage extends StatefulWidget {
  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<bool?>(
      builder: (context, snapshot) {
        final isSenior = snapshot.data == true;

        if (isSenior) {
          return TourGoingOn();
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Tour',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold)),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.blueAccent,
                  size: 30,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<TourModel>>(
                future: ApiManager.getTour(),
                builder: (context, snapshot) {
                  if (snapshot.data == null && snapshot.error == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  }

                  final tourList = snapshot.data;

                  if (tourList?.isEmpty == true) {
                    return const Center(
                      child: Text("Empty Themes"),
                    );
                  }

                  return ListView.builder(
                      itemCount: tourList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final data = tourList![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 10),
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
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    NetworkImage(data.thumbnail.toString()),
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              SingleChildScrollView(
                                child: GestureDetector(
                                  onTap: () async {
                                    final senior = await ApiManager.isSenior();
                                    if (senior == false &&
                                        LocationController.get.userId != null)
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TourDetails(data),
                                        ),
                                      );
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Text('Theme :- ${data.title}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16)),
                                        new Text(
                                            'Tour title :- ${data.tourName}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        new Text(
                                            'Author Name :- ${data.authorName}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        new Text('Date :- ${data.date}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
        );
      },
      future: ApiManager.isSenior(),
    ));
  }
}
