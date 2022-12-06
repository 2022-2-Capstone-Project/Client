import 'dart:convert';
import 'dart:ffi';
import 'package:capstone/theme_model.dart';
import 'package:capstone/tour_request.dart';
import 'package:capstone/tour_response.dart';
import 'package:capstone/user_profile.dart';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_model.dart';

import 'tour_model.dart';
import 'tourApplication_model.dart';

class ApiManager {
  static String BASE_URL = "http://127.0.0.1:8000";
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

  static void saveUsername(
      String username, String token, String userType) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_USERNAME, username);
    prefs.setString(PREF_TOKEN, token);
    _setUserType(userType);
  }

  //PREF_USER_TYPE
  static void _setUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_USER_TYPE, userType);
  }

  static Future<bool?> isSenior() async {
    final prefs = await SharedPreferences.getInstance();
    final isSenior = prefs.getString(PREF_USER_TYPE) == "Senior";
    return isSenior;
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
    return "http://127.0.0.1:8000/sign-up/${profile.id}/";
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

  static Future<String> getThemeName(theme_id) async {
    final themesResponse =
        await getResponse(path: "$BASE_URL/themes/${theme_id}");
    Map theme_name = jsonDecode(themesResponse.body);
    return theme_name['theme_name'];
  }

  static Future<Theme> getThemeDetails(String themeId) async {
    final themeUrl = '$BASE_URL/tour-themes/$themeId/';
    final themeResponse = await getResponse(path: themeUrl);
    final model = Theme.fromJson(json.decode(themeResponse.body));
    return model;
  }

  static Future<List<TourResponse>> getTours() async {
    final response = await getResponse(path: "tours/");

    List<TourResponse> themes = [];

    final result = jsonDecode(response.body);
    final list = List.from(result).map((e) => TourResponse.fromJson(e));
    for (var tour in list) {
      final themeDetails =
          await getThemeDetails((tour.themeId ?? 0).toString());
      tour.themeTitle = themeDetails.title;
      themes.add(tour);
    }

    return themes;
  }

  static Future<TourResponse> createTour(
      TourRequest tourRequest, XFile? imgBytes) async {
    // = await getResponse(path: "$BASE_URL/tours");

    final imageBytes = await imgBytes?.readAsBytes();

    // final request = jsonEncode(themeModel.toJson());

    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$BASE_URL/tours/"),
    );

    request.headers.addAll(
        {"Accept": "application/json", "content-type": "application/json"});

    final imageRequest = http.MultipartFile.fromBytes("thumbnail", imageBytes!,
        contentType: MediaType.parse("image/*"), filename: "new_image.png");

    request.files.add(imageRequest);
    final jsonRequest = tourRequest.toJson();
    request.fields.addAll(jsonRequest);

    print("request: ${tourRequest.toJson()}");

    final response = await request
        .send(); /*await http.post(Uri.parse("$BASE_URL/tour-themes/"),
        body: request,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });*/

    final responseBytes = await response.stream.toBytes();
    final themeResponse = json.decode(String.fromCharCodes(responseBytes));
    return TourResponse.fromJson(themeResponse);
  }

  static Future<List<TourModel>> getTour() async {
    final themesResponse = await getResponse(path: "$BASE_URL/tours");

    // final responseBody = themesResponse.body;

    final themesBody = jsonDecode(utf8.decode(themesResponse.bodyBytes));

    final tourApplicationResponse =
        await getResponse(path: "$BASE_URL/tour-applications");
    final TourApplicationBody =
        jsonDecode((utf8.decode(tourApplicationResponse.bodyBytes)));

    final tourApplications = List.from(TourApplicationBody).map((e) {
      return TourApplicationModel.fromJson(e);
    });

    final themes = List.from(themesBody).map((e) {
      return TourModel.fromJson(e);
    });
    final samar = <TourApplicationModel>[];
    final newTours = <TourModel>[];

    for (var element in themes) {
      // http: //172.30.1.45:8080/tour-themes/2/

      final themeUrl = '$BASE_URL/tour-themes/${element.theme_id}';
      final profileUrl = '$BASE_URL/profiles/${element.profile_id}';

      if (themeUrl != null && (themeUrl.length) > 5) {
        final themeResponse = await getResponse(path: themeUrl);
        final profileResponse = await getResponse(path: profileUrl);

        final model = Theme.fromJson(json.decode(themeResponse.body));
        final profileModel = Author.fromJson(json.decode(profileResponse.body));

        final title = model.title;
        final nickname = profileModel.nickname;
        final followers = 0;

        element.title = title;
        element.authorName = nickname;
        // element.followers = followers != null ? followers.length : 0;
        print(samar);
        // element.tourApplications = tourApplications.toString();
      } else {
        element.title = "n/a";
        element.authorName = "n/a";
        element.followers = null;
      }

      newTours.add(element);
      // getThemeName(newTours.last.theme_id).then((name) {
      //   print(name);
      // });
    }

    return newTours;
  }

  static Future<List<TourApplicationModel>> getTourApplication() async {
    final themesResponse =
        await getResponse(path: "$BASE_URL/tour-applications");
    // final responseBody = themesResponse.body;

    final themesBody = jsonDecode(utf8.decode(themesResponse.bodyBytes));

    final themes = List.from(themesBody).map((e) {
      return TourApplicationModel.fromJson(e);
    });

    final newTourApplications = <TourApplicationModel>[];

    for (var element in themes) {
      //http://172.30.1.45:8080/tour-themes/2/

      newTourApplications.add(element);
    }
    return newTourApplications;
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
