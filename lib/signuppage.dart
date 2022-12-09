import 'package:capstone/api_manager.dart';
import 'package:capstone/junior/nav_bar_junior.dart';
import 'package:capstone/junior/tourpage.dart';
import 'package:capstone/log_in.dart';
import 'package:capstone/senior/homepage.dart';
import 'package:capstone/senior/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SignUp {
  final String username;
  final String password;
  final String nickname;
  final String usertype;

  SignUp({
    required this.username,
    required this.password,
    required this.nickname,
    required this.usertype,
  });

  factory SignUp.fromJson(Map<String, dynamic> json) {
    return SignUp(
      username: json['username'],
      password: json['password'],
      nickname: json['nickname'],
      usertype: json['user_type'],
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _usertypeController = TextEditingController();

  String userTypeValue = "Senior";

  void createAccount(String username, password, nickname, usertype) {
    var data = {};
    http
        .post(
      Uri.parse("${ApiManager.BASE_URL}/sign-up/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'nickname': nickname,
        'user_type': usertype,
      }),
    )
        .then((response) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogInPage()),
      );
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('다시 선택',
            style: TextStyle(color: Colors.black)), // You can add title here
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent, //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('회원 가입',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 14, 99, 246))),
              SizedBox(
                height: 70,
              ),
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
              SizedBox(height: 30),
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
              SizedBox(height: 30),
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
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nickname',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: Color.fromARGB(255, 14, 99, 246)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: DropdownButton(
                          isExpanded: true,
                          value: userTypeValue,
                          items: ["Senior", "Junior"]
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: ((value) {
                            setState(() {
                              if (value == null) return;
                              userTypeValue = value;
                            });
                          }) /*TextField(
                      controller: _usertypeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'User Type',
                      ),
                    )*/
                          ),
                    ),
                  )),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 14, 99, 246),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            createAccount(
                                _usernameController.text,
                                _passwordController.text,
                                _nicknameController.text,
                                userTypeValue);
                          });
                        },
                        child: Text('가입',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                    )),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
