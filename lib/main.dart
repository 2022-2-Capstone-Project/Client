// import 'package:capstone/log_in.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(preferences: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;
  const MyApp({super.key, required this.preferences});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final myUserId = preferences.getString("user_id");
    Get.put(LocationController(myUserId), permanent: true);
    // ignore: prefer_const_constructors
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors

      home: NavBar(),
      //home: LogInPage(),
    );
  }
}
