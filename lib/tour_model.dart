// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class TourModel {
  final int? id;
  final String? tourName;
  final String? date;
  final String? created;
  final String? thumbnail;
  final String? description;
  final int? participants;
  final String? start_place;
  final double? latitude;
  final double? longitude;
  final int? profile_id;
  final int? theme_id;
  String? title;
  String? authorName;
  int? followers;
  List? tourApplications;

  TourModel({
    required this.id,
    required this.tourName,
    required this.date,
    required this.created,
    required this.thumbnail,
    required this.description,
    required this.participants,
    required this.start_place,
    required this.latitude,
    required this.longitude,
    required this.profile_id,
    required this.theme_id,
    required this.title,
    required this.authorName,
    required this.followers,
    required this.tourApplications,
  });
  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
        id: json['id'],
        tourName: json['tourName'],
        date: json['date'],
        created: json['created'],
        thumbnail: json['thumbnail'],
        description: json['description'],
        participants: json['participants'],
        start_place: json['start_place'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        profile_id: json['profile_id'],
        theme_id: json['theme_id'],
        title: json['title'],
        authorName: json['authorName'],
        followers: json['followers'],
        tourApplications: json['tourApplications']);
  }

  String? get dateOnly => created?.split("T").first;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tourName': tourName,
      'date': date,
      'created': created,
      'thumbnail': thumbnail,
      'description': description,
      'participants': participants,
      'start_place': start_place,
      'latitude': latitude,
      'longitude': longitude,
      'profile_id': profile_id,
      'theme_id': theme_id,
      'title': title,
      'authorName': authorName,
      'followers': followers,
      'tourApplications': tourApplications,
    };
  }
}

class Theme {
  String title;

  Theme({required this.title});
  factory Theme.fromJson(Map<String, dynamic> json) {
    return Theme(title: json['title']);
  }
  Map<String, dynamic> toJson() {
    return {'title': title};
  }
}
