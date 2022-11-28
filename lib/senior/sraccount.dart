import 'package:capstone/api_manager.dart';
import 'package:capstone/log_in.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/navigation_bar.dart';
import 'package:capstone/senior/themeswrote.dart';
import 'package:capstone/senior/tourwrote.dart';
import 'package:capstone/user_profile.dart';
import 'package:flutter/material.dart';

class SeniorAccountPage extends StatefulWidget {
  const SeniorAccountPage({Key? key}) : super(key: key);

  @override
  State<SeniorAccountPage> createState() => _SeniorAccountPageState();
}

class _SeniorAccountPageState extends State<SeniorAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('계정',
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold)),
      ),
      body: Builder(builder: (context) {
        if (LocationController.get.userId == null) {
          return Center(
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
          );
        }
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 50),
          child: Container(
            child: FutureBuilder<UserProfile>(
              builder: (context, snapshot) {
                UserProfile? userProfile = snapshot.data;
                print(userProfile?.toJson());

                String? firstNameIn = userProfile?.firstName?.trim();
                String? lastNameIn = userProfile?.lastName?.trim();

                if ((firstNameIn?.length ?? 0) > 1) {
                  firstNameIn = firstNameIn?[0];
                }

                if ((lastNameIn?.length ?? 0) >= 1) {
                  lastNameIn = lastNameIn?[0];
                }

                String initials = '$firstNameIn$lastNameIn';

                if (initials.isEmpty) {
                  initials = "${userProfile?.nickname}".trim()[0].toUpperCase();
                }

                return ListView(children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  backgroundColor: Colors.pink.shade100,
                                  child: Text(initials,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black)),
                                  radius: 35),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('${userProfile?.nickname}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        ".",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('${userProfile?.userType}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.favorite_outline),
                                      Text("${userProfile?.likes?.length}"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(Icons.money),
                                      Text("${userProfile?.point}")
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
              },
              future: ApiManager.getProfileDetail(),
            ),
          ),
        );
      }),
      floatingActionButton: LocationController.get.userId == null
          ? null
          : FloatingActionButton.extended(
              heroTag: "log out",
              onPressed: () {
                ApiManager.deleteUserId();
                LocationController.get.userId = null;

                //logout
                ApiManager.logOut().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => NavBar(),
                      ),
                      ((route) => false));
                });
              },
              label: const Text('Log Out'),
              backgroundColor: Color.fromARGB(255, 14, 99, 246),
            ),
    );
  }
}
