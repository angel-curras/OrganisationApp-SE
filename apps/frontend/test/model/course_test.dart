import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/model/weekday.dart';

void main() {
  group('Empty course tests', () {
    test('Empty course', () {
      Course course = Course();

      expect(course, isNotNull);
      expect(course.id, 0);
      expect(course.name, '');
      expect(course.responsible, '');
      expect(course.progress, 0);
      expect(course.startDate, null);
      expect(course.endDate, null);
      expect(course.lectureWeekday, null);
      expect(course.lectureStartTime, null);
      expect(course.lectureEndTime, null);
      expect(course.labWeekday, null);
      expect(course.labStartTime, null);
      expect(course.labEndTime, null);
    }); // end of Empty course test

    test('Empty course to JSON Map', () {
      Course course = Course();

      expect(course, isNotNull);
      expect(course.toJsonMap(), isNotNull);
      expect(course.toJsonMap()['course_id'], 0);
      expect(course.toJsonMap()['course_name'], '');
      expect(course.toJsonMap()['responsible'], '');
      expect(course.toJsonMap()['progress'], 0);
      expect(course.toJsonMap()['start_date'], null);
      expect(course.toJsonMap()['end_date'], null);
      expect(course.toJsonMap()['lecture_weekday'], null);
      expect(course.toJsonMap()['lecture_start_time'], null);
      expect(course.toJsonMap()['lecture_end_time'], null);
      expect(course.toJsonMap()['lab_weekday'], null);
      expect(course.toJsonMap()['lab_start_time'], null);
      expect(course.toJsonMap()['lab_end_time'], null);
    }); // end of Empty course to json test

    test('Empty course from JSON Map', () {
      Course course = Course.fromJsonMap({});

      expect(course, isNotNull);
      expect(course.id, 0);
      expect(course.name, '');
      expect(course.responsible, '');
      expect(course.progress, 0);
      expect(course.startDate, null);
      expect(course.endDate, null);
      expect(course.lectureWeekday, null);
      expect(course.lectureStartTime, null);
      expect(course.lectureEndTime, null);
      expect(course.labWeekday, null);
      expect(course.labStartTime, null);
      expect(course.labEndTime, null);
    }); // end of Empty course from json test

    test('Empty course to JSON String', () {
      Course course = Course();

      expect(course, isNotNull);
      expect(course.toJsonString(), isNotNull);
      expect(course.toJsonString(),
          '{"course_id":0,"course_name":"","responsible":"","progress":0,"start_date":null,"end_date":null,"lecture_weekday":null,"lecture_start_time":null,"lecture_end_time":null,"lab_weekday":null,"lab_start_time":null,"lab_end_time":null}');
    }); // end of Empty course to json string test

    test('Empty course from JSON String', () {
      Course course = Course.fromJsonString('{}');

      expect(course, isNotNull);
      expect(course.id, 0);
      expect(course.name, '');
      expect(course.responsible, '');
      expect(course.progress, 0);
      expect(course.startDate, null);
      expect(course.endDate, null);
      expect(course.lectureWeekday, null);
      expect(course.lectureStartTime, null);
      expect(course.lectureEndTime, null);
      expect(course.labWeekday, null);
      expect(course.labStartTime, null);
      expect(course.labEndTime, null);
    }); // end of Empty course from json string test
  }); // end of Empty course tests group

  group("Fully filled Courses", () {
    test("Fully filled course", () {
      Course course = Course(
        id: 1,
        name: 'Test Course',
        responsible: 'Test Responsible',
        progress: 100,
        startDate: DateTime(2020, 1, 1),
        endDate: DateTime(2020, 2, 1),
        lectureWeekday: Weekday.monday,
        lectureStartTime: const TimeOfDay(hour: 8, minute: 0),
        lectureEndTime: const TimeOfDay(hour: 10, minute: 0),
        labWeekday: Weekday.tuesday,
        labStartTime: const TimeOfDay(hour: 8, minute: 0),
        labEndTime: const TimeOfDay(hour: 10, minute: 0),
      );

      expect(course, isNotNull);
      expect(course.id, 1);
      expect(course.name, 'Test Course');
      expect(course.responsible, 'Test Responsible');
      expect(course.progress, 100);
      expect(course.startDate, DateTime(2020, 1, 1));
      expect(course.endDate, DateTime(2020, 2, 1));
      expect(course.lectureWeekday, Weekday.monday);
      expect(course.lectureStartTime, const TimeOfDay(hour: 8, minute: 0));
      expect(course.lectureEndTime, const TimeOfDay(hour: 10, minute: 0));
      expect(course.labWeekday, Weekday.tuesday);
      expect(course.labStartTime, const TimeOfDay(hour: 8, minute: 0));
      expect(course.labEndTime, const TimeOfDay(hour: 10, minute: 0));
    }); // end of Fully filled course test

    test("Fully filled course to JSON Map", () {
      Course course = Course(
        id: 1,
        name: 'Test Course',
        responsible: 'Test Responsible',
        progress: 100,
        startDate: DateTime(2020, 1, 1),
        endDate: DateTime(2020, 2, 1),
        lectureWeekday: Weekday.monday,
        lectureStartTime: const TimeOfDay(hour: 8, minute: 0),
        lectureEndTime: const TimeOfDay(hour: 10, minute: 0),
        labWeekday: Weekday.tuesday,
        labStartTime: const TimeOfDay(hour: 8, minute: 0),
        labEndTime: const TimeOfDay(hour: 10, minute: 0),
      );

      expect(course, isNotNull);
      expect(course.toJsonMap(), isNotNull);
      expect(course.toJsonMap()['course_id'], 1);
      expect(course.toJsonMap()['course_name'], 'Test Course');
      expect(course.toJsonMap()['responsible'], 'Test Responsible');
      expect(course.toJsonMap()['progress'], 100);
      expect(course.toJsonMap()['start_date'], '2020-01-01T00:00:00.000');
      expect(course.toJsonMap()['end_date'], '2020-02-01T00:00:00.000');
      expect(course.toJsonMap()['lecture_weekday'], "MONDAY");
      expect(course.toJsonMap()['lecture_start_time'], '08:00:00');
      expect(course.toJsonMap()['lecture_end_time'], '10:00:00');
      expect(course.toJsonMap()['lab_weekday'], "TUESDAY");
      expect(course.toJsonMap()['lab_start_time'], '08:00:00');
      expect(course.toJsonMap()['lab_end_time'], '10:00:00');
    }); // end of Fully filled course to json test

    test("Fully filled course from JSON Map", () {
      Course course = Course.fromJsonMap({
        'course_id': 1,
        'course_name': 'Test Course',
        'responsible': 'Test Responsible',
        'progress': 100,
        'start_date': '2020-01-01T00:00:00.000',
        'end_date': '2020-02-01T00:00:00.000',
        'lecture_weekday': "MONDAY",
        'lecture_start_time': '08:00:00',
        'lecture_end_time': '10:00:00',
        'lab_weekday': "TUESDAY",
        'lab_start_time': '08:00:00',
        'lab_end_time': '10:00:00',
      });

      expect(course, isNotNull);
      expect(course.id, 1);
      expect(course.name, 'Test Course');
      expect(course.responsible, 'Test Responsible');
      expect(course.progress, 100);
      expect(course.startDate, DateTime(2020, 1, 1));
      expect(course.endDate, DateTime(2020, 2, 1));
      expect(course.lectureWeekday, Weekday.monday);
      expect(course.lectureStartTime, const TimeOfDay(hour: 8, minute: 0));
      expect(course.lectureEndTime, const TimeOfDay(hour: 10, minute: 0));
      expect(course.labWeekday, Weekday.tuesday);
      expect(course.labStartTime, const TimeOfDay(hour: 8, minute: 0));
      expect(course.labEndTime, const TimeOfDay(hour: 10, minute: 0));
    }); // end of Fully filled course from json test
  }); // end of Fully filled Courses group
}
