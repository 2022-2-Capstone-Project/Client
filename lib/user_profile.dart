class UserProfile {
  String? url;
  int? id;
  String? password;
  dynamic lastLogin;
  bool? isSuperuser;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  bool? isStaff;
  bool? isActive;
  String? dateJoined;
  String? nickname;
  String? userType;
  int? point;
  int? reputation;
  List<String?>? groups;
  List<dynamic>? userPermissions;
  List<dynamic>? bookmarks;
  List<dynamic>? likes;
  List<dynamic>? follows;
  List<dynamic>? followers;

  UserProfile(
      {this.url,
      this.password,
      this.lastLogin,
      this.isSuperuser,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.isStaff,
      this.isActive,
      this.dateJoined,
      this.nickname,
      this.userType,
      this.reputation,
      this.groups,
      this.userPermissions,
      this.bookmarks,
      this.likes,
      this.follows,
      this.point,
      this.id,
      this.followers});

  UserProfile.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    password = json['password'];
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    nickname = json['nickname'];
    id = json["id"];
    userType = json['user_type'];
    reputation = json['reputation'];
    if (json['groups'] != null) {
      groups = <String>[];
      json['groups'].forEach((v) {
        groups!.add(v);
      });
    }
    if (json['user_permissions'] != null) {
      userPermissions = <dynamic>[];
      json['user_permissions'].forEach((v) {
        userPermissions!.add(v);
      });
    }
    if (json['bookmarks'] != null) {
      bookmarks = <Null>[];
      json['bookmarks'].forEach((v) {
        bookmarks!.add(v);
      });
    }
    if (json['likes'] != null) {
      likes = <dynamic>[];
      json['likes'].forEach((v) {
        likes!.add(v);
      });
    }
    if (json['follows'] != null) {
      follows = <dynamic>[];
      json['follows'].forEach((v) {
        follows!.add(v);
      });
    }
    if (json['followers'] != null) {
      followers = <dynamic>[];
      json['followers'].forEach((v) {
        followers!.add(v);
      });
    }
    point = json["point"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['password'] = password;
    data['last_login'] = this.lastLogin;
    data['is_superuser'] = this.isSuperuser;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['is_staff'] = this.isStaff;
    data['is_active'] = this.isActive;
    data['date_joined'] = this.dateJoined;
    data['nickname'] = this.nickname;
    data['user_type'] = this.userType;
    data['reputation'] = this.reputation;
    data['id'] = this.id;
    data['point'] = this.point;

    data['groups'] = groups;
    if (this.userPermissions != null) {
      data['user_permissions'] = userPermissions;
    }
    if (this.bookmarks != null) {
      data['bookmarks'] = this.bookmarks!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    if (this.follows != null) {
      data['follows'] = this.follows!.map((v) => v.toJson()).toList();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
