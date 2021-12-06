// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      json['studentUid'] as String,
      json['studentName'] as String,
      json['studentEmail'] as String,
      json['departmentUid'] as String,
      json['departmentName'] as String,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'studentUid': instance.studentUid,
      'studentName': instance.studentName,
      'studentEmail': instance.studentEmail,
      'departmentUid': instance.departmentUid,
      'departmentName': instance.departmentName,
    };
