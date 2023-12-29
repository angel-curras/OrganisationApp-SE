import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/model/weekday.dart';

void main() {
  test('Monday from JSON', () {
    Weekday weekday = WeekdayExtension.fromJSON('MONDAY');
    expect(weekday, isNotNull);
    expect(weekday, Weekday.monday);
  }); // end of Monday test

  test('Tuesday from JSON', () {
    Weekday weekday = WeekdayExtension.fromJSON('TUESDAY');
    expect(weekday, isNotNull);
    expect(weekday, Weekday.tuesday);
  }); // end of Tuesday test

  test('Wednesday from JSON', () {
    Weekday weekday = WeekdayExtension.fromJSON('WEDNESDAY');
    expect(weekday, isNotNull);
    expect(weekday, Weekday.wednesday);
  }); // end of Wednesday test

  test('Thursday from JSON', () {
    Weekday weekday = WeekdayExtension.fromJSON('THURSDAY');
    expect(weekday, isNotNull);
    expect(weekday, Weekday.thursday);
  }); // end of Thursday test

  test('Friday from JSON', () {
    Weekday weekday = WeekdayExtension.fromJSON('FRIDAY');
    expect(weekday, isNotNull);
    expect(weekday, Weekday.friday);
  }); // end of Friday test

  test('Saturday from JSON', () {
    Weekday weekday = WeekdayExtension.fromJSON('SATURDAY');
    expect(weekday, isNotNull);
    expect(weekday, Weekday.saturday);
  }); // end of Saturday test

  test('Sunday from JSON', () {
    Weekday weekday = WeekdayExtension.fromJSON('SUNDAY');
    expect(weekday, isNotNull);
    expect(weekday, Weekday.sunday);
  }); // end of Sunday test

  test('Default (monday) to JSON', () {
    Weekday weekday = WeekdayExtension.fromJSON('');
    expect(weekday, isNotNull);
    expect(weekday, Weekday.monday);
  }); // end of Monday test

  test('Monday to JSON', () {
    String weekday = Weekday.monday.toJSON();
    expect(weekday, isNotNull);
    expect(weekday, 'MONDAY');
  }); // end of Monday test

  test('Tuesday to JSON', () {
    String weekday = Weekday.tuesday.toJSON();
    expect(weekday, isNotNull);
    expect(weekday, 'TUESDAY');
  }); // end of Tuesday test

  test('Wednesday to JSON', () {
    String weekday = Weekday.wednesday.toJSON();
    expect(weekday, isNotNull);
    expect(weekday, 'WEDNESDAY');
  }); // end of Wednesday test

  test('Thursday to JSON', () {
    String weekday = Weekday.thursday.toJSON();
    expect(weekday, isNotNull);
    expect(weekday, 'THURSDAY');
  }); // end of Thursday test

  test('Friday to JSON', () {
    String weekday = Weekday.friday.toJSON();
    expect(weekday, isNotNull);
    expect(weekday, 'FRIDAY');
  }); // end of Friday test

  test('Saturday to JSON', () {
    String weekday = Weekday.saturday.toJSON();
    expect(weekday, isNotNull);
    expect(weekday, 'SATURDAY');
  }); // end of Saturday test

  test('Sunday to JSON', () {
    String weekday = Weekday.sunday.toJSON();
    expect(weekday, isNotNull);
    expect(weekday, 'SUNDAY');
  }); // end of Sunday test
} // end of main()
