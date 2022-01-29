// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faculty _$FacultyFromJson(Map<String, dynamic> json) => Faculty(
      json['facultyUid'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['address'] as String,
      json['departmentUid'] as String,
    );

Map<String, dynamic> _$FacultyToJson(Faculty instance) => <String, dynamic>{
      'facultyUid': instance.facultyUid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'departmentUid': instance.departmentUid,
    };
