import 'package:college_app/models/attendance_args.dart';
import 'package:college_app/screens/faculty_screens/add_student.dart';
import 'package:college_app/screens/faculty_screens/department_list.dart';
import 'package:college_app/screens/faculty_screens/take_attendance.dart';
import 'package:flutter/material.dart';

// variable for our route names
const String departmentList = 'department_list';
const String addStudent = 'add_student';
const String takeAttendance = 'takeAttendance';

// controller function with switch statement to control page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case departmentList:
      return MaterialPageRoute(builder: (context) => const DepartmentList());
    case addStudent:
      return MaterialPageRoute(builder: (context) => const AddStudent());
    case takeAttendance:
      final args = settings.arguments! as AttendanceArgs;
      return MaterialPageRoute(
          builder: (_) =>
              TakeAttendance(args.departmentUid, args.facultyUid));
    default:
      throw ('this route name does not exist');
  }
}
