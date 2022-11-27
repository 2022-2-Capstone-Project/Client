import 'package:capstone/api_manager.dart';
import 'package:capstone/log_in.dart';
import 'package:capstone/user_profile.dart';
import 'package:flutter/material.dart';

class JuniorAccountPage extends StatefulWidget {
  const JuniorAccountPage({Key? key}) : super(key: key);

  @override
  State<JuniorAccountPage> createState() => _JuniorAccountPageState();
}

class _JuniorAccountPageState extends State<JuniorAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('계정',
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 50),
        child: Container(
          child: FutureBuilder<UserProfile>(
            builder: (context, snapshot) {
              UserProfile? userProfile = snapshot.data;

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

              return ListView(
                children: [
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
                                      Text("1200")
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(
                                Icons.arrow_right,
                                size: 35,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        ListTile(
                          leading: Icon(Icons.article, size: 35),
                          title:
                              Text('내가 신청한 투어', style: TextStyle(fontSize: 20)),
                          trailing: Icon(Icons.arrow_right_sharp, size: 35),
                          iconColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            future: ApiManager.getProfileDetail(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "log out",
        onPressed: () {
          //logout
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogInPage(),
            ),
          );
        },
        label: const Text('Log Out'),
        backgroundColor: Color.fromARGB(255, 14, 99, 246),
      ),
    );
  }
}
