import 'package:capstone/senior/location_service.dart';
import 'package:get/get.dart';
import 'dart:convert';
// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController {
  String? userId;
  LocationController(this.userId);

  static LocationController get = Get.find();

  Placemark _pickPlaceMark = Placemark();

  Placemark get pickPlaceMark => _pickPlaceMark;

  // void setu(params) {
  //   userId = "";

  // }

  List<Prediction> _predictionList = [];

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      print("my status is " + data["status"]);
      if (data['status'] == 'OK') {
        _predictionList = [];
        data['predictions'].forEach((prediction) =>
            _predictionList.add(Prediction.fromJson(prediction)));
      } else {
        //APIChecker.checkApi(response);
      }
    }
    return _predictionList;
  }
}
