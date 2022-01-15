// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faculty _$FacultyFromJson(Map<String, dynamic> json) => Faculty(
      json['facultyUid'] as String,
      json['name'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['address'] as String,
      json['departmentUid'] as String,
    );

Map<String, dynamic> _$FacultyToJson(Faculty instance) => <String, dynamic>{
      'facultyUid': instance.facultyUid,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'departmentUid': instance.departmentUid,
    };
