import 'package:capstone/junior/confirmregpage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text('신청하기',
                  style:
                      TextStyle(color: Colors.black)), // You can add title here
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor:
                  Colors.transparent, //You can make this transparent
              elevation: 0.0, //No shadow
            ),
          ),
          SizedBox(
            height: 30,
          ),
          //기본 정보 (to be updated)
          Container(
            height: 300,
            width: 340,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 14, 99, 246)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text('테마 정보')),
          ),
          SizedBox(
            height: 60,
          ),
          // agree to register
          Column(
            children: [
              Text('위 투어 신청하시겠습니까?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),

              //주의 사항 (2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.announcement),
                  SizedBox(
                    width: 10,
                  ),
                  Text('정해진 시간에 맞춰서 오시기 바랍니다', style: TextStyle(fontSize: 17)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.announcement),
                  SizedBox(
                    width: 20,
                  ),
                  Text('투어 진행하는 동안 예의 꼭 지키기 바랍니다.',
                      style: TextStyle(fontSize: 17)),
                ],
              ),
              SizedBox(
                height: 40,
              ),

              //button for 신청 & 채팅
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 14, 99, 246),
                        ),
                        child: Center(
                          child: Text('채팅',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmRegPage(),
                                ),
                              );
                            },
                            child: Text('신청',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
