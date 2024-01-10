import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/shared/date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    // Perform any necessary initial setup
  });

  testWidgets('DatePickerTask opens date picker and selects a date',
      (WidgetTester tester) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    DateTime selectedDate = DateTime.now();
    bool datePicked = false;

    // Function to set date picked to true when a date is selected
    void onDateSelected(DateTime date) {
      datePicked = true;
      selectedDate = date;
    }

    // Create the DatePickerTask widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DatePickerTask(
            restorationId: 'date_picker_task',
            onDateSelected: onDateSelected,
          ),
        ),
      ),
    );

    // Tap the button to trigger the date picker
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    await tester.pumpAndSettle(); // Wait for the date picker to display

    // Confirm the selected date by tapping the 'OK' button
    await tester.tap(find.text('OK').hitTestable());
    await tester.pumpAndSettle();

    // Check if the callback was called with a date selection
    expect(datePicked, isTrue);
    expect(selectedDate, isNotNull);

    // Check if the selected date is the expected date
    final expectedDate =
        DateTime(DateTime.now().year, DateTime.now().month, selectedDate.day);
    expect(selectedDate, isNotNull);
    expect(selectedDate, expectedDate);

    // Verify the Snackbar with the selected date appears
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.textContaining(selectedDate.day.toString()), findsOneWidget);

    // Check if the date picker dialog is closed
    expect(find.byType(DatePickerDialog), findsNothing);
  });
}
