import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organisation_app/model/weekday.dart';

class Course {
  final int id;
  final String name;
  final String responsible;
  final int progress;
  DateTime? startDate;
  DateTime? endDate;
  Weekday? lectureWeekday;
  TimeOfDay? lectureStartTime;
  TimeOfDay? lectureEndTime;
  Weekday? labWeekday;
  TimeOfDay? labStartTime;
  TimeOfDay? labEndTime;

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

  static String? timeOfDayToString(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return null;
    }
    return DateFormat('HH:mm:ss').format(DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        timeOfDay.hour,
        timeOfDay.minute));
  }

  static TimeOfDay? stringToTimeOfDay(String? timeString) {
    if (timeString == null) {
      return null;
    }
    return TimeOfDay.fromDateTime(DateFormat('HH:mm:ss').parse(timeString));
  }

  Map<String, dynamic> toJsonMap() => {
        'course_id': id,
        'course_name': name,
        'responsible': responsible,
        'progress': progress,
        'start_date': startDate?.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'lecture_weekday': lectureWeekday?.toJSON(),
        'lecture_start_time': timeOfDayToString(lectureStartTime),
        'lecture_end_time': timeOfDayToString(lectureEndTime),
        'lab_weekday': labWeekday?.toJSON(),
        'lab_start_time': timeOfDayToString(labStartTime),
        'lab_end_time': timeOfDayToString(labEndTime),
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
            ? WeekdayExtension.fromJSON(json['lecture_weekday'] as String)
            : null,
        lectureStartTime: json['lecture_start_time'] != null
            ? stringToTimeOfDay(json['lecture_start_time'])
            : null,
        lectureEndTime: json['lecture_end_time'] != null
            ? stringToTimeOfDay(json['lecture_end_time'])
            : null,
        labWeekday: json['lab_weekday'] != null
            ? WeekdayExtension.fromJSON(json['lab_weekday'] as String)
            : null,
        labStartTime: json['lab_start_time'] != null
            ? stringToTimeOfDay(json['lab_start_time'])
            : null,
        labEndTime: json['lab_end_time'] != null
            ? stringToTimeOfDay(json['lab_end_time'])
            : null,
      );

  String toJsonString() => jsonEncode(toJsonMap());

  factory Course.fromJsonString(String jsonString) =>
      Course.fromJsonMap(jsonDecode(jsonString));
}
