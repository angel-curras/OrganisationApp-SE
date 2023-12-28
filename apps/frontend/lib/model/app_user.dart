import 'dart:convert';

enum UserType { guest, student, admin }

extension UserTypeExtension on UserType {
  String toJSON() {
    switch (this) {
      case UserType.guest:
        return 'GUEST';
      case UserType.student:
        return 'STUDENT';
      case UserType.admin:
        return 'ADMIN';
    }
  }

  static UserType fromJSON(String userType) {
    switch (userType) {
      case 'GUEST':
        return UserType.guest;
      case 'STUDENT':
        return UserType.student;
      case 'ADMIN':
        return UserType.admin;
      default:
        return UserType.guest;
    }
  }
}

class AppUser {
  String userName;
  String fullName;
  UserType userType;

  AppUser({
    this.userName = '',
    this.fullName = '',
    this.userType = UserType.guest,
  });

  Map<String, dynamic> toJsonMap() => {
        'user_name': userName,
        'full_name': fullName,
        'user_type': userType.toJSON(),
      };

  factory AppUser.fromJsonMap(Map<String, dynamic> json) => AppUser(
        userName: json['user_name'] ?? '',
        fullName: json['full_name'] ?? '',
        userType: UserTypeExtension.fromJSON(json['user_type'] ?? ''),
      );

  String toJsonString() => jsonEncode(toJsonMap());

  factory AppUser.fromJsonString(String jsonString) =>
      AppUser.fromJsonMap(jsonDecode(jsonString));
}
