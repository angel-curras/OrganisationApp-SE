import 'dart:convert';

class CourseSubscription {
  int moduleId;
  String userName;

  CourseSubscription({
    required this.moduleId,
    required this.userName,
  });

  Map<String, dynamic> toJsonMap() => {
        'module_id': moduleId,
        'user_name': userName,
      };

  factory CourseSubscription.fromJsonMap(Map<String, dynamic> json) =>
      CourseSubscription(
        moduleId: json['module_id'] ?? '',
        userName: json['user_name'] ?? '',
      );

  String toJsonString() => jsonEncode(toJsonMap());

  factory CourseSubscription.fromJsonString(String jsonString) =>
      CourseSubscription.fromJsonMap(jsonDecode(jsonString));
}
