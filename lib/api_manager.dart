import 'dart:convert';
import 'dart:ffi';
import 'package:capstone/theme_model.dart';
import 'package:capstone/user_profile.dart';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiManager {
  static String BASE_URL = "http://172.30.1.45:8080";
  static String PREF_USERNAME = "pref_username";
  static String PREF_TOKEN = "pref_TOKEN";
  static String PREF_USER_TYPE = "pref_USER_TYPE";

  @Deprecated("Use getResponse({path})")
  static Future<http.Response> get(String url) {
    return http.get(Uri.parse(url), headers: {
      "Accept": "application/json",
      "content-type": "application/json",
    });
  }

  static Future<http.Response> getResponse(
      {required String path, String? token}) {
    final header = {
      "Accept": "application/json",
      "content-type": "application/json",
    };
    if (token != null) {
      header["Authorization"] = "Bearer $token";
    }
    if (path.startsWith("$BASE_URL")) {
      path = path.replaceFirst("$BASE_URL/", "");
    }
    print("baseurl : $BASE_URL/$path");
    return http.get(Uri.parse("$BASE_URL/$path"), headers: header);
  }

  static void saveUsername(String username, String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_USERNAME, username);
    prefs.setString(PREF_TOKEN, token);
  }

  //PREF_USER_TYPE
  static void setUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_USER_TYPE, userType);
  }

  static Future<bool?> isSenior() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PREF_USER_TYPE);
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(PREF_USERNAME) ?? "";
    return username;
  }

  static Future<String> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(PREF_USERNAME) ?? "";
    return username;
  }

  static void deleteUserId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("PREF_USERNAME");
    prefs.remove("PREF_TOKEN");
  }

  static Future<ThemeModel> getTheme(
      ThemeModel themeModel, XFile? imgBytes) async {
    final imageBytes = await imgBytes?.readAsBytes();

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

    print("request: ${themeModel.toJson()}");

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

  static Future<UserProfile> getProfileDetail({String? username}) async {
    final prefs = await SharedPreferences.getInstance();
    final myUsername =
        username == null ? prefs.getString(PREF_USERNAME) : username;
    final token = prefs.getString(PREF_TOKEN);
    print("newURL: $token \N $myUsername");
    final response =
        await getResponse(path: "user_info/$myUsername/", token: token);
    final body = await json.decode(response.body);
    return UserProfile.fromJson(body);
  }

  static Future<String> generateAurthorUrl() async {
    final profile = await getProfileDetail();
    //"http://172.30.1.45:8080/sign-up/3/
    return "http://172.30.1.45:8080/sign-up/${profile.id}/";
  }

  static Future<List<String>> getThemeTitles() async {
    final themes = await getThemes();
    return themes.map((e) => e.title ?? "").toList();
  }

  static Future<String> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    return "User logged out";
  }

  static Future<List<ThemeModel>> getThemes() async {
    final themesResponse = await get("$BASE_URL/tour-themes");
    // final responseBody = themesResponse.body;

    final themesBody = jsonDecode(utf8.decode(themesResponse.bodyBytes));

    final themes = List.from(themesBody).map((e) {
      return ThemeModel.fromJson(e);
    });

    final newThemes = <ThemeModel>[];

    for (var element in themes) {
      //http://172.30.1.45:8080/tour-themes/2/
      final author = element.author;
      if (author != null && (author.length) > 5) {
        final authorResponse = await getResponse(path: author);
        final profile = await getProfileDetail();

        final model = Author.fromJson(json.decode(authorResponse.body));
        final username = model.username;
        element.author = username;
        element.nickname = model.nickname;
        element.rating = "${profile.reputation ?? 0}";
        element.followers = "${profile.followers?.length ?? 0}";
      } else {
        element.author = "n/a";
      }
      newThemes.add(element);
    }

    return newThemes;
  }
}
