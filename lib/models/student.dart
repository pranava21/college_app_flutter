import 'package:college_app/endpoint.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'department.dart';
import 'dart:convert';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final String studentUid;
  String studentName;
  String studentEmail;
  String departmentUid;
  String departmentName;

  Student(this.studentUid, this.studentName, this.studentEmail,
      this.departmentUid, this.departmentName);

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  static Future<List<Student>> fetchStudentsByDepartment(
      String departmentUid) async {
    var uri = Endpoint.uri('Student/$departmentUid', queryParameters: {});
    final response = await http.get(uri);

    if (response.statusCode != 200) throw (response.body);

    List<Student> students = <Student>[];
    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    for (var student in decodedResponse['response']) {
      students.add(Student.fromJson(student));
    }

    return students;
  }
}
