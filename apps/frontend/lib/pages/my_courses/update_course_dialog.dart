import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/controller/course_controller.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/model/weekday.dart';

class UpdateCourseDialog extends StatefulWidget {
  // Fields.
  final CourseController _courseController;
  final Course _course;

  UpdateCourseDialog(
      {super.key, required http.Client client, required Course course})
      : _course = course,
        _courseController = CourseController(client: client);

  @override
  State<UpdateCourseDialog> createState() => _UpdateCourseDialogState();
}

class _UpdateCourseDialogState extends State<UpdateCourseDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _onUpdateClicked(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await widget._courseController.updateCourse(widget._course);

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return pickedTime;
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            // Start of the list view.

            // Course card infos:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course name:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Course: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget._course.name,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Course responsible:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Responsible: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget._course.responsible,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Course progress:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Progress: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "${widget._course.progress}%",
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Start date: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              key: const Key("startDateButton"),
                              onPressed: () async {
                                DateTime? pickedDate =
                                    await _selectDate(context);
                                if (pickedDate != null) {
                                  setState(() {
                                    widget._course.startDate = pickedDate;
                                  });
                                }
                              },
                              child: Text(widget._course.startDate == null
                                  ? "Select date"
                                  : '${widget._course.startDate!.day}/${widget._course.startDate!.month}/${widget._course.startDate!.year}'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "End date: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              key: const Key("endDateButton"),
                              onPressed: () async {
                                DateTime? pickedDate =
                                    await _selectDate(context);
                                if (pickedDate != null) {
                                  setState(() {
                                    widget._course.endDate = pickedDate;
                                  });
                                }
                              },
                              child: Text(widget._course.endDate == null
                                  ? "Select date"
                                  : '${widget._course.endDate!.day}/${widget._course.endDate!.month}/${widget._course.endDate!.year}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Course settings: lecture
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Lecture:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Day of week: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<Weekday>(
                                key: const Key("lectureWeekDayDropdownButton"),
                                value: widget._course.lectureWeekday,
                                decoration: const InputDecoration(
                                  hintText: "Please select the lecture day",
                                ),
                                onChanged: (Weekday? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      widget._course.lectureWeekday = newValue;
                                    });
                                  }
                                },
                                items: Weekday.values.map((weekday) {
                                  return DropdownMenuItem<Weekday>(
                                      value: weekday,
                                      child: Text(
                                        weekday.toJSON(),
                                      ));
                                }).toList(),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Start time: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              key: const Key("lectureStartTimeButton"),
                              onPressed: () async {
                                TimeOfDay? pickedTime =
                                    await _selectTime(context);
                                if (pickedTime != null) {
                                  setState(() {
                                    widget._course.lectureStartTime =
                                        pickedTime;
                                  });
                                }
                              },
                              child: Text(
                                widget._course.lectureStartTime == null
                                    ? "Select time"
                                    : widget._course.lectureStartTime!
                                        .format(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "End time: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              key: const Key("lectureEndTimeButton"),
                              onPressed: () async {
                                TimeOfDay? pickedTime =
                                    await _selectTime(context);
                                if (pickedTime != null) {
                                  setState(() {
                                    widget._course.lectureEndTime = pickedTime;
                                  });
                                }
                              },
                              child: Text(
                                widget._course.lectureEndTime == null
                                    ? "Select time"
                                    : widget._course.lectureEndTime!
                                        .format(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Course settings: lab
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Lab:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Day of week: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<Weekday>(
                                key: const Key("labWeekDayDropdownButton"),
                                value: widget._course.labWeekday,
                                decoration: const InputDecoration(
                                  hintText: "Please select the lab day",
                                ),
                                onChanged: (Weekday? newValue) {
                                  if (newValue == null) {
                                    return;
                                  }
                                  setState(() {
                                    widget._course.labWeekday = newValue;
                                  });
                                },
                                items: Weekday.values.map((weekday) {
                                  return DropdownMenuItem<Weekday>(
                                      value: weekday,
                                      child: Text(
                                        weekday.toJSON(),
                                      ));
                                }).toList(),
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Start time: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              key: const Key("labStartTimeButton"),
                              onPressed: () async {
                                TimeOfDay? pickedTime =
                                    await _selectTime(context);
                                if (pickedTime != null) {
                                  setState(() {
                                    widget._course.labStartTime = pickedTime;
                                  });
                                }
                              },
                              child: Text(
                                widget._course.labStartTime == null
                                    ? "Select time"
                                    : widget._course.labStartTime!
                                        .format(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "End time: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              key: const Key("labEndTimeButton"),
                              onPressed: () async {
                                TimeOfDay? pickedTime =
                                    await _selectTime(context);
                                if (pickedTime != null) {
                                  setState(() {
                                    widget._course.labEndTime = pickedTime;
                                  });
                                }
                              },
                              child: Text(
                                widget._course.labEndTime == null
                                    ? "Select time"
                                    : widget._course.labEndTime!
                                        .format(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Save button:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                key: const Key("updateButton"),
                onPressed: () => _onUpdateClicked(context),
                child: const Text("Update"),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
