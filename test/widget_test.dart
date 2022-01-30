// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:college_app/models/add_student_model.dart';
import 'package:college_app/models/attendance.dart';
import 'package:college_app/models/department.dart';
import 'package:college_app/models/faculty.dart';
import 'package:college_app/models/student.dart';
import 'package:college_app/models/user.dart';
import 'package:test/test.dart';

void main() {
  test('test /Department/GetAllDepartments', () async {
    final departments = await Department.fetchAllDepartments();

    for (var dept in departments) {
      expect(dept.departmentName, hasLength(greaterThan(0)));
    }
  });

  test('test /Student/departmentUid', () async {
    final students = await Student.fetchStudentsByDepartment(
        'd1d7b25b-1ba1-419c-bf7d-790295d29e96');

    for (var student in students) {
      expect(student.studentFirstName, hasLength(greaterThan(0)));
    }
  });

  test('/Student/AddStudent', () async {
    AddStudentModel student = AddStudentModel(
        "Keerthana",
        "Menon",
        "krocks@gmail.com",
        "8747639",
        "Bangalore, Karnataka",
        "024c877b-84dd-4897-9f03-55fc14523bf6",
        "Electrical and Electronics");
    final response = await Student.addStudent(student);

    expect(response, isFalse);
  });

  test('/Faculty/GetAllFaculty', () async {
    final faculties = await Faculty.getFacultyDetailsByDepartment(
        'f049da45-1712-4c13-817a-cfb1faae4ea2');

    for (var faculty in faculties) {
      expect(faculty.firstName, hasLength(greaterThan(0)));
      expect(faculty.email, hasLength(greaterThan(0)));
    }
  });

  test('/Student/TakeAttendance', () async {
    List<Attendance> attendanceDetails = <Attendance>[];
    attendanceDetails.addAll([
      Attendance(
          0,
          "086e8af0-0aa3-46cc-b095-3515053bbc2c",
          "c84e7003-0ff7-4de2-b9a9-1604a1ace0d3",
          "f049da45-1712-4c13-817a-cfb1faae4ea2",
          DateTime.now(),
          true),
      Attendance(
          0,
          "086e8af0-0aa3-46cc-b095-3515053bbc2c",
          "c815ce6b-1a0a-4a01-91e5-5587b3ebb16c",
          "f049da45-1712-4c13-817a-cfb1faae4ea2",
          DateTime.now(),
          true),
      Attendance(
          0,
          "086e8af0-0aa3-46cc-b095-3515053bbc2c",
          "f8f81b7d-0419-4ee5-98d0-454cdf6e5c07",
          "f049da45-1712-4c13-817a-cfb1faae4ea2",
          DateTime.now(),
          false)
    ]);

    final response =
        await Attendance.submitAttendanceDetails(attendanceDetails);

    expect(response, isTrue);
  });

  test('GetUserDetails', () async {
    UserDetails? user = await UserDetails.GetUser('jkpranava16@gmail.com');

    expect(user?.emailId, 'jkpranava16@gmail.com');
  });

  test('GetStudent', () async {
    Student student = await Student.fetchStudentDetails('jkpranava16@gmail.com', 'f049da45-1712-4c13-817a-cfb1faae4ea2');

    expect(student.studentEmail, 'jkpranava16@gmail.com');
    expect(student.departmentName, "Computer Science");
  });
}
