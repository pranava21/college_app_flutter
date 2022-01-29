import 'package:college_app/models/attendance.dart';
import 'package:college_app/models/student.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:rflutter_alert/rflutter_alert.dart';

class TakeAttendance extends StatefulWidget {
  final String departmentUid;
  final String facultyUid;

  const TakeAttendance(this.departmentUid, this.facultyUid, {Key? key})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  createState() => _TakeAttendanceState(departmentUid, facultyUid);
}

class _TakeAttendanceState extends State<TakeAttendance> {
  final _formKey = GlobalKey<FormState>();

  final String departmentUid;
  final String facultyUid;

  List<Attendance> attendanceDetails = [];
  List<Student> studentDetails = [];
  bool isLoading = false;

  bool attendanceTaken = false;

  _TakeAttendanceState(this.departmentUid, this.facultyUid);

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Take Attendance'),
          actions: [
            IconButton(
                icon: const Icon(Icons.cancel_rounded),
                onPressed: () => onCancelCick(context)),
            IconButton(
                icon: const Icon(Icons.done_outline_rounded),
                onPressed: () => renderSubmitPopUp(context))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Builder(
                  builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        renderStudentsListView(context),
                        //renderSubmitButton(context)
                      ],
                    ),
                  ),
                ))));
  }

  Future<void> loadStudents() async {
    if (mounted) {
      setState(() => isLoading = true);

      final students = await Student.fetchStudentsByDepartment(departmentUid);

      setState(() {
        studentDetails = students;
        formAttendancePayLoad();
        isLoading = false;
      });
    }
  }

  void formAttendancePayLoad() {
    studentDetails.forEach((student) => {
          attendanceDetails.add(Attendance(0, facultyUid, student.studentUid,
              departmentUid, DateTime.now(), false))
        });
  }

  Widget renderProgressBar(BuildContext context) {
    return (isLoading
        ? const CircularProgressIndicator(
            backgroundColor: Colors.white, color: Colors.blue)
        : Container());
  }

  Widget renderStudentsListView(BuildContext context) {
    return ListView.builder(
      itemCount: studentDetails.length,
      itemBuilder: _renderStudentRow,
      shrinkWrap: true,
    );
  }

  Widget _renderStudentRow(BuildContext context, int index) {
    return SwitchListTile(
      title: Text(studentDetails[index].studentFirstName),
      value: attendanceDetails[index].isPresent,
      onChanged: (bool value) {
        setState(() {
          attendanceDetails[index].isPresent = value;
        });
      },
      activeColor: Colors.red,
      inactiveTrackColor: Colors.grey,
      secondary: const Icon(Icons.person),
      tileColor: index % 2 == 0 ? Colors.white : Colors.grey[100],
    );
  }

  Widget renderSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final form = _formKey.currentState;
        if (form!.validate()) {
          form.save();
          //submitStudentDetails(student, dropDownValue, selectedDepartmentUid);
        }
      },
      child: const Text(
        'Submit Attendance Details',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  void onCancelCick(BuildContext context) async {
    Alert(
        context: context,
        type: AlertType.warning,
        title: "Sure?",
        desc: "Are you sure you want to cancel?",
        buttons: [
          DialogButton(
            child: const Text("Cancel",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textWidthBasis: TextWidthBasis.longestLine),
            onPressed: () {
              _navigateToHomePage(context);
            },
            width: 200,
          )
        ],
        closeFunction: () {
          _navigateToHomePage(context);
        }).show();
  }

  renderSubmitPopUp(BuildContext context) async {
    if (!attendanceTaken) {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Wait up!",
        desc:
            "Are you sure you want to Proceed? You cannot change once submitted",
        buttons: [
          DialogButton(
            child: const Text("Submit Details",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textWidthBasis: TextWidthBasis.longestLine),
            onPressed: () => successPopUp(context),
            width: 200,
          )
        ],
      ).show();
    } else {
      Alert(
          context: context,
          type: AlertType.error,
          title: "Error!",
          desc: "Details already submitted",
          buttons: [
            DialogButton(
              child: const Text("Go to Home Page",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textWidthBasis: TextWidthBasis.longestLine),
              onPressed: () {
                _navigateToHomePage(context);
              },
              width: 200,
            )
          ],
          closeFunction: () {
            _navigateToHomePage(context);
          }).show();
    }
  }

  void successPopUp(BuildContext context) async {
    var response = await Attendance.submitAttendanceDetails(attendanceDetails);
    if (response) {
      attendanceTaken = true;
      Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Attendance Recorded successfully!",
          buttons: [
            DialogButton(
              child: const Text("Go to homepage",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  textWidthBasis: TextWidthBasis.longestLine),
              onPressed: () {
                _navigateToHomePage(context);
              },
              width: 200,
            )
          ],
          closeFunction: () {
            _navigateToHomePage(context);
          }).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Something went wrong",
        desc: "Details were not saved",
        buttons: [
          DialogButton(
            child: const Text("Back",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textWidthBasis: TextWidthBasis.longestLine),
            onPressed: () => () {
              developer.log("API error: " + response.toString());
              Navigator.of(context).pop();
            },
            width: 200,
          )
        ],
      ).show();
    }
  }

  _navigateToHomePage(BuildContext context) {
    Navigator.popUntil(context, (route) {
      return route.settings.name == "/";
    });
  }
}
