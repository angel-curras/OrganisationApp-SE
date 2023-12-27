enum WeekdayEnum {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension Weekday on WeekdayEnum {
  String toJSON() {
    switch (this) {
      case WeekdayEnum.monday:
        return 'MONDAY';
      case WeekdayEnum.tuesday:
        return 'TUESDAY';
      case WeekdayEnum.wednesday:
        return 'WEDNESDAY';
      case WeekdayEnum.thursday:
        return 'THURSDAY';
      case WeekdayEnum.friday:
        return 'FRIDAY';
      case WeekdayEnum.saturday:
        return 'SATURDAY';
      case WeekdayEnum.sunday:
        return 'SUNDAY';
    }
  }

  WeekdayEnum fromJSON(String weekday) {
    switch (weekday) {
      case 'MONDAY':
        return WeekdayEnum.monday;
      case 'TUESDAY':
        return WeekdayEnum.tuesday;
      case 'WEDNESDAY':
        return WeekdayEnum.wednesday;
      case 'THURSDAY':
        return WeekdayEnum.thursday;
      case 'FRIDAY':
        return WeekdayEnum.friday;
      case 'SATURDAY':
        return WeekdayEnum.saturday;
      case 'SUNDAY':
        return WeekdayEnum.sunday;
      default:
        return WeekdayEnum.monday;
    }
  }
}
