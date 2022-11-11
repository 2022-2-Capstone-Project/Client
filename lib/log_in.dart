import 'package:capstone/srorjrpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                '재밌는 투어하면서 친구 사귀자! 로그인하세요',
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
                        onTap: () {},
                        child: Text('로그인',
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
                  Text('아이디 없으세요?',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SrorJrPage()));
                    },
                    child: Text(' 회원 가입',
                        style: TextStyle(
                            color: Color.fromARGB(255, 14, 99, 246),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
