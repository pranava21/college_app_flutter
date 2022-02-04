// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) => Attendance(
      json['attendanceId'] as int,
      json['facultyUid'] as String,
      json['studentUid'] as String,
      json['departmentUid'] as String,
      DateTime.parse(json['attendedOn'] as String),
      json['isPresent'] as bool,
    );

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'attendanceId': instance.attendanceId,
      'facultyUid': instance.facultyUid,
      'studentUid': instance.studentUid,
      'departmentUid': instance.departmentUid,
      'attendedOn': instance.attendedOn.toIso8601String(),
      'isPresent': instance.isPresent,
    };
