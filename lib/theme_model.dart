class ThemeModel {
  String? created;
  String? thumbnail;
  String? title;
  int? participants;
  dynamic lat;
  dynamic long;
  int? estimated;
  String startPlace;
  String? description;
  String? author;
  bool premium;
  String? nickname;
  String? rating;
  String? followers;
  String? url;
  String? category;

  ThemeModel(
      {this.lat,
      this.url,
      this.long,
      this.created,
      this.participants = 0,
      this.thumbnail,
      required this.estimated,
      required this.startPlace,
      required this.description,
      required this.premium,
      this.author,
      this.nickname,
      this.title,
      required this.category});

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      category: json["category"] ?? "",
      url: json["url"],
      lat: json["latitude"],
      long: json["longitude"],
      thumbnail: json["thumbnail"],
      title: json["title"],
      premium: json["is_premium"],
      participants: json['participants'],
      estimated: json["estimated"],
      startPlace: json['start_place'] ?? "",
      description: json["description"] ?? "",
      author: json['author'] ?? "",
      created: json['created'],
      nickname: json['nickname'],
    );
  }

  String? get dateOnly => created?.split("T").first;

  Map<String, String> toJson() {
    return {
      "latitude": lat.toString(),
      "longitude": long.toString(),
      "thumbnail": thumbnail ?? "",
      "title": title ?? "",
      "participants": participants.toString(),
      "start_place": startPlace,
      "description": description ?? "",
      "created": created ?? "",
      "is_premium": premium.toString(),
      "author": author ?? "",
      "estimated": estimated.toString(),
      "nickname": nickname.toString(),
      "url": url ?? "",
      "category": category ?? ""
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
class Author {
  String username;
  String nickname;

  Author({required this.username, required this.nickname});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(username: json["username"], nickname: json['nickname']);
  }

  Map<String, dynamic> toJson() {
    return {"username": username, "nickname": nickname};
  }
}
