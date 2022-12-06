class TourResponse {
  int? id;
  String? tourName;
  String? date;
  String? created;
  String? thumbnail;
  String? description;
  int? participants;
  String? startPlace;
  double? latitude;
  double? longitude;
  int? profileId;
  int? themeId;
  String? themeTitle;

  TourResponse(
      {this.id,
      this.tourName,
      this.date,
      this.created,
      this.thumbnail,
      this.description,
      this.participants,
      this.startPlace,
      this.latitude,
      this.longitude,
      this.profileId,
      this.themeId});

  TourResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tourName = json['tourName'];
    date = json['date'];
    created = json['created'];
    thumbnail = json['thumbnail'];
    description = json['description'];
    participants = json['participants'];
    startPlace = json['start_place'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    profileId = json['profile_id'];
    themeId = json['theme_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tourName'] = this.tourName;
    data['date'] = this.date;
    data['created'] = this.created;
    data['thumbnail'] = this.thumbnail;
    data['description'] = this.description;
    data['participants'] = this.participants;
    data['start_place'] = this.startPlace;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['profile_id'] = this.profileId;
    data['theme_id'] = this.themeId;
    return data;
  }
}
