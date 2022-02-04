// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      json['studentUid'] as String,
      json['studentId'] as String,
      json['studentFirstName'] as String,
      json['studentLastName'] as String,
      json['studentEmail'] as String,
      json['phoneNo'] as String,
      json['departmentUid'] as String,
      json['departmentName'] as String,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'studentUid': instance.studentUid,
      'studentId': instance.studentId,
      'studentFirstName': instance.studentFirstName,
      'studentLastName': instance.studentLastName,
      'studentEmail': instance.studentEmail,
      'phoneNo': instance.phoneNo,
      'departmentUid': instance.departmentUid,
      'departmentName': instance.departmentName,
    };
