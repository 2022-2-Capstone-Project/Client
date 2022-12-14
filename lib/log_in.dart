import 'package:capstone/api_manager.dart';
import 'package:capstone/junior/nav_bar_junior.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/navigation_bar.dart';
import 'package:capstone/signuppage.dart';
// import 'package:capstone/srorjrpage.dart';
// import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:async/async.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:capstone/signuppage.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<bool> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('token', value);
}

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showLogin({bool? isSenior}) async {
// dataMap["user_type"] == "Senior"
    final username = await ApiManager.getUsername();
    final senior = isSenior; //?? await ApiManager.isSenior();

    if (username.isEmpty) {
      return;
    }

    if (senior == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
      );
    } else if (senior == false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavBarJr()),
      );
    }
  }

  @override
  void initState() {
    showLogin();
    super.initState();
  }

  void auth(String username, password) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await getToken();
    // var accesstoken = "";
    // var data = {};

    try {
      final response = await http.post(
        Uri.parse("${ApiManager.BASE_URL}/token/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      final accessToken = json.decode(response.body)["access"];
      final dataMap = Jwt.parseJwt(accessToken);

      ApiManager.saveUsername(
          dataMap['username'], accessToken, dataMap['user_type']);

      LocationController.get.userId = dataMap['username'];
      showLogin(isSenior: dataMap['user_type'] == "Senior");
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login failed. Please try again"),
        duration: Duration(seconds: 2),
      ));
    }

    /*.then((response) => json
                .decode(response.body)["access"]
                .then((accesstoken) => Jwt.parseJwt(accesstoken))
                .then((data) {
              if (data["user_type"] == "Senior") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavBar()),
                );
              } else if (data["user_type"] == "Junior") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavBarJr()),
                );
              }
            }).catchError((error) {
              print(error);
            }));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 14, 99, 246)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('?????????',
            style: TextStyle(
                color: Color.fromARGB(255, 14, 99, 246),
                fontSize: 25,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //picture

            //app name
            Text('Sherpa', style: GoogleFonts.lobster(fontSize: 50)),

            //welcome intro
            Text(
              '????????? ??????????????? ?????? ?????????! ??????????????????',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            //username
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 14, 99, 246)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            //password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 14, 99, 246)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            //login button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                  height: 30,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 14, 99, 246),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          auth(
                            _usernameController.text,
                            _passwordController.text,
                          );
                        });
                      },
                      child: Text('?????????',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  )),
            ),

            SizedBox(height: 20),

            //signup button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('????????? ?????????????',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(' ?????? ??????',
                      style: TextStyle(
                          color: Color.fromARGB(255, 14, 99, 246),
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
