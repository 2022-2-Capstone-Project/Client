import 'package:capstone/junior/confirmregpage.dart';
import 'package:capstone/junior/jraccount.dart';
import 'package:capstone/junior/nav_bar_junior.dart';
import 'package:capstone/junior/registerpage.dart';
import 'package:capstone/junior/tourpage.dart';
import 'package:capstone/senior/confirmeditpage.dart';
import 'package:capstone/senior/editthemepage.dart';
import 'package:capstone/senior/edittourdetails.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/maketourpage.dart';
import 'package:capstone/senior/mapframe.dart';
import 'package:capstone/senior/navigation_bar.dart';
import 'package:capstone/senior/confirmthemepage.dart';
import 'package:capstone/senior/homepage.dart';
import 'package:capstone/senior/makethemepage.dart';
import 'package:capstone/senior/sraccount.dart';
import 'package:capstone/senior/themedetailspage.dart';
import 'package:capstone/senior/themeswrote.dart';
import 'package:capstone/senior/tourgoingon.dart';
import 'package:capstone/senior/tourwrote.dart';
import 'package:capstone/signuppage.dart';
import 'package:capstone/srorjrpage.dart';
import 'package:flutter/material.dart';
import 'package:capstone/log_in.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:capstone/senior/location_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    // ignore: prefer_const_constructors
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: LogInPage(),
    );
  }
}
