import 'dart:convert';

import 'package:college_app/endpoint.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'department.g.dart';

@JsonSerializable()
class Department {
  final String departmentUid;
  String departmentName;
  String departmentImageUrl;

  Department(this.departmentUid, this.departmentName, this.departmentImageUrl);

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  static Future<List<Department>> fetchAllDepartments() async {
    var uri = Endpoint.uri('/Department/GetDepartments', queryParameters: {});

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw response.body;
    }
    List<Department> listOfDepartments = <Department>[];

    var responseBody = json.decode(response.body);

    for (var department in responseBody['response']) {
      listOfDepartments.add(Department.fromJson(department));
    }

    return listOfDepartments;
  }
}
