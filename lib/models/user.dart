import 'dart:core';
import 'dart:convert';

import 'package:college_app/endpoint.dart';
import 'package:college_app/models/response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'user.g.dart';

@JsonSerializable()
class UserDetails {
  String userId;
  String firstName;
  String lastName;
  String phone;
  String emailId;
  String address;
  int age;
  String departmentUid;
  bool isStudent;
  bool isFaculty;

  UserDetails(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.emailId,
      required this.address,
      required this.age,
      required this.departmentUid,
      required this.isStudent,
      required this.isFaculty});

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  static Future<ResponseMessage> AddUserToDatabase(
      UserDetails user, String facultyOrStudent) async {
    var uri = Endpoint.uri('Accounts/AddUser',
        queryParameters: {'facultyOrStudent': facultyOrStudent});

    var body = json.encode(user.toJson());

    final res = await http
        .post(uri, body: body, headers: {"Content-Type": "application/json"});
    final Map<String, dynamic> result = json.decode(res.body);
    ResponseMessage response = ResponseMessage();
    response.isSucess = result['isSuccess'];
    response.responseMessage = result['message'];

    return response;
  }

  static Future<UserDetails?> GetUser(String emailId) async {
    var uri =
        Endpoint.uri('Accounts/GetUser', queryParameters: {'emailId': emailId});
    var res = await http.get(uri);
    final Map<String, dynamic> result = json.decode(res.body);

    var userDetails = result['response'];

    UserDetails? user;
    if (userDetails != null) {
      user = UserDetails.fromJson(userDetails);
    }
    else {
      user = null;
    }

    return user;
  }
}
