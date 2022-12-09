import 'package:capstone/senior/tourgoingon.dart';
import 'package:capstone/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_time_patterns.dart';

import '../api_manager.dart';
import '../tour_model.dart';
import '../user_profile.dart';

class RegisterTourPage extends StatefulWidget {
  final UserProfile userProfile;
  const RegisterTourPage({Key? key, required this.userProfile})
      : super(key: key);

  @override
  State<RegisterTourPage> createState() => _RegisterTourPageState();
}

class _RegisterTourPageState extends State<RegisterTourPage> {
  List<TourModel>? tours;
  dynamic tour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내가 신청한 투어',
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
      body: FutureBuilder<List<dynamic>>(
          future: widget.userProfile.userType == "Senior"
              ? ApiManager.getTour()
              : ApiManager.getJuniorTour(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            tour = snapshot.data!;
            print(snapshot.runtimeType);
            if (snapshot.runtimeType == List<TourModel>) {
              tour = snapshot.data!
                  .where((element) => element.profile_id == 3)
                  .toList();
            }

            return ListView.builder(
                itemCount: tour.length,
                itemBuilder: (context, index) {
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
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 50,
                          ),
                          SingleChildScrollView(
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TourGoingOn()),
                                );
                              },
                              child: Center(
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(tour![index].title!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(tour![index].date.toString(),
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    const Icon(
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
                  );
                });
          }),
    );
  }
}
