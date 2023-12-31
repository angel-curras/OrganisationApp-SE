import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/model/course_subscription.dart';

void main() {
  group('Course subscription (filled)', () {
    test('Course subscription to JSON', () {
      CourseSubscription courseSubscription = CourseSubscription(
        moduleId: 1,
        userName: 'test',
      );

      String expectedJsonString = '{"module_id":1,"user_name":"test"}';
      expect(courseSubscription.toJsonString(), expectedJsonString);
    }); // end of Course subscription to JSON

    test('Course subscription from JSON', () {
      CourseSubscription courseSubscription = CourseSubscription.fromJsonString(
          '{"module_id":1,"user_name":"test"}');

      expect(courseSubscription, isNotNull);
      expect(courseSubscription.moduleId, 1);
      expect(courseSubscription.userName, 'test');
    }); // end of Course subscription from JSON
  }); // end of Fully filled Courses group
}
