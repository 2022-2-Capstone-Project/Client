import 'dart:convert';
import 'package:capstone/theme_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class ApiManager {
  static String BASE_URL = "http://172.20.10.2:8080";

  static Future<ThemeModel> getTheme(
      ThemeModel themeModel, XFile? imgBytes) async {
    final imageBytes = await imgBytes?.readAsBytes();

    themeModel.thumbnail = imgBytes != null && imageBytes != null
        ? "data:image/png;base64,${base64Encode(imageBytes)}"
        : "";

    // final request = jsonEncode(themeModel.toJson());

    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$BASE_URL/tour-themes/"),
    );

    request.headers.addAll(
        {"Accept": "application/json", "content-type": "application/json"});

    final imageRequest = http.MultipartFile.fromBytes("thumbnail", imageBytes!,
        contentType: MediaType.parse("image/*"), filename: "new_image.png");

    request.files.add(imageRequest);
    request.fields.addAll(themeModel.toJson());

    print("request: $request");

    final response = await request
        .send(); /*await http.post(Uri.parse("$BASE_URL/tour-themes/"),
        body: request,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });*/

    final responseBytes = await response.stream.toBytes();
    final themeResponse = json.decode(String.fromCharCodes(responseBytes));
    return ThemeModel.fromJson(themeResponse);
  }
}
