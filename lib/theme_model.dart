class ThemeModel {
  String? thumbnail;
  String? title;
  String? category;
  int? participants;
  dynamic lat;
  dynamic long;
  int estimated;
  String startPlace;
  String? description;

  ThemeModel(
      {this.lat,
      this.long,
      this.category,
      this.participants = 0,
      this.thumbnail,
      required this.estimated,
      required this.startPlace,
      required this.description,
      this.title});

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
        lat: json["latitude"],
        long: json["longitude"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        participants: json['participants'],
        estimated: json["estimated"],
        startPlace: json['start_place'] ?? "",
        category: json["category"],
        description: json["description"] ?? "");
  }

  Map<String, String> toJson() {
    return {
      "latitude": lat.toString(),
      "longitude": long.toString(),
      "thumbnail": thumbnail ?? "",
      "title": title ?? "",
      "category": category ?? "",
      "participants": participants.toString(),
      "start_place": startPlace,
      "description": description ?? "",
      "estimated": estimated.toString()
    };
  }
}

/*
 "url": "http://172.20.10.2:8080/tour-themes/2/",
    "created": null,
    "title": "Name of title",
    "estimated": 2,
    "participants": 1,
    "start_place": "Seoul",
    "latitude": -10.3,
    "longitude": 10.4,
    "thumbnail": null,
    "checkpoints": "",
    "description": "hello",
    "author": null
*/
