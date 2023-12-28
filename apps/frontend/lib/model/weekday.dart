enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension WeekdayExtension on Weekday {
  String toJSON() {
    switch (this) {
      case Weekday.monday:
        return 'MONDAY';
      case Weekday.tuesday:
        return 'TUESDAY';
      case Weekday.wednesday:
        return 'WEDNESDAY';
      case Weekday.thursday:
        return 'THURSDAY';
      case Weekday.friday:
        return 'FRIDAY';
      case Weekday.saturday:
        return 'SATURDAY';
      case Weekday.sunday:
        return 'SUNDAY';
    }
  }

  static Weekday fromJSON(String weekday) {
    switch (weekday.toUpperCase()) {
      case 'MONDAY':
        return Weekday.monday;
      case 'TUESDAY':
        return Weekday.tuesday;
      case 'WEDNESDAY':
        return Weekday.wednesday;
      case 'THURSDAY':
        return Weekday.thursday;
      case 'FRIDAY':
        return Weekday.friday;
      case 'SATURDAY':
        return Weekday.saturday;
      case 'SUNDAY':
        return Weekday.sunday;
      default:
        return Weekday.monday;
    }
  }
}
