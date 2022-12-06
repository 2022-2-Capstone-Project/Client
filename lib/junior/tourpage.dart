import 'package:capstone/api_manager.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/tourgoingon.dart';
import 'package:capstone/tour_response.dart';
import 'package:flutter/material.dart';
import 'package:capstone/junior/tourdetails.dart';

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
              child: Column(
                children: [
                  Expanded(
                      child: FutureBuilder<List<TourResponse>>(
                    builder: (context, snapshot) {
                      if (snapshot.data == null && snapshot.error == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            TourResponse? tour = snapshot.data?[index];
                            return Container(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(70),
                                      child: tour?.thumbnail == null
                                          ? Icon(Icons.image)
                                          : Image.network(
                                              "${tour?.thumbnail}",
                                              fit: BoxFit
                                                  .cover, //tour?.thumbnail
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${tour?.tourName}"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text("${tour?.date}"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text("${tour?.themeTitle}")
                                    ],
                                  ))
                                ],
                              ),
                            );
                          });
                    },
                    future: ApiManager.getTours(),
                  ))
                ],
              )),
        );
      },
      future: ApiManager.isSenior(),
    ));
  }
}
