// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      userId: json['userId'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      emailId: json['emailId'] as String,
      address: json['address'] as String,
      age: json['age'] as int,
      departmentUid: json['departmentUid'] as String,
      isStudent: json['isStudent'] as bool,
      isFaculty: json['isFaculty'] as bool,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'emailId': instance.emailId,
      'address': instance.address,
      'age': instance.age,
      'departmentUid': instance.departmentUid,
      'isStudent': instance.isStudent,
      'isFaculty': instance.isFaculty,
    };
