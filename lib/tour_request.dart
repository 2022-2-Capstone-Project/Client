class TourRequest {
  String? tourName;
  String? date;
  String? thumbnail;
  String? description;
  int? participants;
  String? startPlace;
  double? latitude;
  double? longitude;
  int? profileId;
  int? themeId;

  TourRequest(
      {this.tourName,
      this.date,
      this.thumbnail,
      this.description,
      this.participants,
      this.startPlace,
      this.latitude,
      this.longitude,
      this.profileId,
      this.themeId});

  TourRequest.fromJson(Map<String, dynamic> json) {
    tourName = json['tourName'];
    date = json['date'];
    thumbnail = json['thumbnail'];
    description = json['description'];
    participants = json['participants'];
    startPlace = json['start_place'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    profileId = json['profile_id'];
    themeId = json['theme_id'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['tourName'] = this.tourName?.toString() ?? "";
    data['date'] = this.date ?? "";
    data['thumbnail'] = this.thumbnail ??
        "https://www.shutterstock.com/image-photo/example-word-written-on-wooden-260nw-1765482248.jpg";
    data['description'] = this.description ?? "";
    data['participants'] = this.participants.toString();
    data['start_place'] = this.startPlace ?? "";
    data['latitude'] = this.latitude.toString();
    data['longitude'] = this.longitude.toString();
    data['profile_id'] = this.profileId.toString();
    data['theme_id'] = this.themeId.toString();
    return data;
  }
}
