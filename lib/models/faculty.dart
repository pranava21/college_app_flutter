import 'dart:convert';
import 'package:college_app/endpoint.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'faculty.g.dart';

@JsonSerializable()
class Faculty {
  String facultyUid;
  String firstName;
  String lastName;
  String email;
  String phone;
  String address;
  String departmentUid;

  Faculty(this.facultyUid, this.firstName, this.lastName, this.email, this.phone, this.address,
      this.departmentUid);

  factory Faculty.fromJson(Map<String, dynamic> json) =>
      _$FacultyFromJson(json);

  static Future<List<Faculty>> getFacultyDetailsByDepartment(
      String departmentUid) async {
    var uri = Endpoint.uri('/Faculty/GetAllFaculty',
        queryParameters: {"departmentUid": departmentUid});

    final response = await http.get(uri);

    List<Faculty> listOfFaculty = <Faculty>[];

    var responseBody = json.decode(response.body);

    for (var faculty in responseBody['response']) {
      listOfFaculty.add(Faculty.fromJson(faculty));
    }

    return listOfFaculty;
  }
}
