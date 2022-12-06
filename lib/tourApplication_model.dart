import 'package:get/get.dart';

class TourApplicationModel {
  final int? id;
  final int? participants_on_site;
  final bool? tour_finished;
  final String? created;
  final String? tour;
  final List? user;

  TourApplicationModel(
      {required this.id,
      required this.participants_on_site,
      required this.tour_finished,
      required this.created,
      required this.tour,
      required this.user});
  factory TourApplicationModel.fromJson(Map<String, dynamic> json) {
    return TourApplicationModel(
        id: json['id'],
        participants_on_site: json['participants_on_site'],
        tour_finished: json['tour_finished'],
        created: json['created'],
        tour: json['tour'],
        user: json['user']);
  }
  String? get dateOnly => created?.split("T").first;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants_on_site': participants_on_site,
      'tour_finished': tour_finished,
      'created': created,
      'tour': tour,
      'user': user
    };
  }
}
