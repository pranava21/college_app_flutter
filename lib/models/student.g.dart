// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      json['studentId'] as int,
      json['studentName'] as String,
      json['phoneNo'] as String,
      json['email'] as String,
      json['departmentId'] as String,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'phoneNo': instance.phoneNo,
      'email': instance.email,
      'departmentId': instance.departmentId,
    };
