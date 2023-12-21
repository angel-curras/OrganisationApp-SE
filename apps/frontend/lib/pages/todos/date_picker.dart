import 'package:flutter/material.dart';

typedef OnDateSelectedCallback = void Function(DateTime selectedDate);

/// RestorationProperty objects can be used because of RestorationMixin.
class DatePickerTask extends StatefulWidget {
  const DatePickerTask({
    Key? key,
    this.restorationId,
    this.onDateSelected,
  }) : super(key: key);

  final String? restorationId;
  final OnDateSelectedCallback? onDateSelected;

  @override
  State<DatePickerTask> createState() => _DatePickerTaskState();
}

class _DatePickerTaskState extends State<DatePickerTask>
    with RestorationMixin {
  final RestorableDateTime _selectedDate = RestorableDateTime(
    DateTime.now(),
  );
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static const int _minYear = 2000;
  static const int _maxYear = 3000;

  static Route<DateTime> _datePickerRoute(BuildContext context,
      Object? arguments,) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(_minYear),
          lastDate: DateTime(_maxYear),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Selected: ${_selectedDate.value.day}/${_selectedDate.value
                    .month}/${_selectedDate.value.year}'),
          ),
        );
      });
      widget.onDateSelected?.call(newSelectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      child: const Text('Pick a date'),
    );
  }

  @override
  String? get restorationId => widget.restorationId;
}
