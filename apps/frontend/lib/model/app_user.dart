import 'dart:convert';

class AppUser {
  String userName;
  String fullName;
  String userType;

  AppUser({
    this.userName = 'guest',
    this.fullName = "Special guest",
    this.userType = 'GUEST',
  });

  // Method to convert Dart object to JSON Map
  Map<String, dynamic> toJsonMap() => {
        'user_name': userName,
        'full_name': fullName,
        'user_type': userType,
      };

// Method to convert JSON Map to Dart object
  factory AppUser.fromJsonMap(Map<String, dynamic> json) => AppUser(
        userName: json['user_name'],
        fullName: json['full_name'],
        userType: json['user_type'],
      );

  // Convert to json string
  String toJsonString() => jsonEncode(toJsonMap());

  // Convert from json string
  factory AppUser.fromJsonString(String jsonString) =>
      AppUser.fromJsonMap(jsonDecode(jsonString));
}
