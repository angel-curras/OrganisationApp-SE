import 'dart:convert';

import 'package:organisation_app/model/weekday.dart';

class Course {
  final int id;
  final String name;
  final String responsible;
  final int progress;
  final DateTime? startDate;
  final DateTime? endDate;
  final WeekdayEnum? lectureWeekday;
  final DateTime? lectureStartTime;
  final DateTime? lectureEndTime;
  final WeekdayEnum? labWeekday;
  final DateTime? labStartTime;
  final DateTime? labEndTime;

  Course(
      {this.id = 0,
      this.name = '',
      this.responsible = '',
      this.progress = 0,
      this.startDate,
      this.endDate,
      this.lectureWeekday,
      this.lectureStartTime,
      this.lectureEndTime,
      this.labWeekday,
      this.labStartTime,
      this.labEndTime});

  Map<String, dynamic> toJsonMap() => {
        'course_id': id,
        'course_name': name,
        'responsible': responsible,
        'progress': progress,
        'start_date': startDate?.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'lecture_weekday': lectureWeekday?.index,
        'lecture_start_time': lectureStartTime?.toIso8601String(),
        'lecture_end_time': lectureEndTime?.toIso8601String(),
        'lab_weekday': labWeekday?.index,
        'lab_start_time': labStartTime?.toIso8601String(),
        'lab_end_time': labEndTime?.toIso8601String(),
      };

  factory Course.fromJsonMap(Map<String, dynamic> json) => Course(
        id: json['course_id'] ?? 0,
        name: json['course_name'] ?? '',
        responsible: json['responsible'] ?? '',
        progress: json['progress'] ?? 0,
        startDate: json['start_date'] != null
            ? DateTime.parse(json['start_date'])
            : null,
        endDate:
            json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
        lectureWeekday: json['lecture_weekday'] != null
            ? WeekdayEnum.values[json['lecture_weekday']]
            : null,
        lectureStartTime: json['lecture_start_time'] != null
            ? DateTime.parse(json['lecture_start_time'])
            : null,
        lectureEndTime: json['lecture_end_time'] != null
            ? DateTime.parse(json['lecture_end_time'])
            : null,
        labWeekday: json['lab_weekday'] != null
            ? WeekdayEnum.values[json['lab_weekday']]
            : null,
        labStartTime: json['lab_start_time'] != null
            ? DateTime.parse(json['lab_start_time'])
            : null,
        labEndTime: json['lab_end_time'] != null
            ? DateTime.parse(json['lab_end_time'])
            : null,
      );

  String toJsonString() => jsonEncode(toJsonMap());

  factory Course.fromJsonString(String jsonString) =>
      Course.fromJsonMap(jsonDecode(jsonString));
}
