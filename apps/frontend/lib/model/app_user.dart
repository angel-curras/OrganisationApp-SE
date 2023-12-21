import 'dart:convert';

class AppUser {
  String userName;
  String fullName;
  String userType;

  AppUser({
    this.userName = '',
    this.fullName = '',
    this.userType = '',
  });

  Map<String, dynamic> toJsonMap() => {
        'user_name': userName,
        'full_name': fullName,
        'user_type': userType,
      };

  factory AppUser.fromJsonMap(Map<String, dynamic> json) => AppUser(
        userName: json['user_name'] ?? '',
        fullName: json['full_name'] ?? '',
        userType: json['user_type'] ?? '',
      );

  String toJsonString() => jsonEncode(toJsonMap());

  factory AppUser.fromJsonString(String jsonString) =>
      AppUser.fromJsonMap(jsonDecode(jsonString));
}
