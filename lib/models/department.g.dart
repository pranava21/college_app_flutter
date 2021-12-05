// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      json['departmentUid'] as String,
      json['departmentName'] as String,
      json['departmentImageUrl'] as String,
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'departmentUid': instance.departmentUid,
      'departmentName': instance.departmentName,
      'departmentImageUrl': instance.departmentImageUrl,
    };
