import 'package:college_app/endpoint.dart';
import 'package:college_app/models/add_student_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'department.dart';
import 'dart:convert';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final String studentUid;
  String studentId;
  String studentFirstName;
  String studentLastName;
  String studentEmail;
  String phoneNo;
  String departmentUid;
  String departmentName;

  Student(
      this.studentUid,
      this.studentId,
      this.studentFirstName,
      this.studentLastName,
      this.studentEmail,
      this.phoneNo,
      this.departmentUid,
      this.departmentName);

  Student.blank()
      : studentId = '',
        studentFirstName = "",
        studentLastName = "",
        studentEmail = "",
        departmentUid = "",
        departmentName = "",
        phoneNo = "",
        studentUid = '';

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

  static Future<bool> AddStudent(AddStudentModel student) async {
    var uri = Endpoint.uri('Student/AddStudent', queryParameters: {});
    Map requestBody = {
      "firstName": student.firstName,
      "lastName": student.lastName,
      "email": student.email,
      "phone": student.phone,
      "address": student.address,
      "departmentUid": student.departmentUid,
      "departmentName": student.departmentName
    };
    var body = json.encode(requestBody);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode != 200) return false;

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    return decodedResponse['isSuccess'];
  }
}
