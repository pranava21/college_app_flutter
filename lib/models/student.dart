import 'package:json_annotation/json_annotation.dart';

import 'department.dart';
part 'student.g.dart';

@JsonSerializable()
class Student {
  final int studentId;
  String studentName;
  String phoneNo;
  String email;
  String departmentId;

  Student(this.studentId, this.studentName, this.phoneNo, this.email,
      this.departmentId);

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
