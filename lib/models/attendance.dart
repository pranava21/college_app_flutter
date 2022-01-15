import 'package:college_app/endpoint.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  int attendanceId;
  String facultyUid;
  String studentUid;
  String departmentUid;
  DateTime attendedOn;
  bool isPresent;

  Attendance(this.attendanceId, this.facultyUid, this.studentUid,
      this.departmentUid, this.attendedOn, this.isPresent);

  Map toJson() => {
        'attendanceId': attendanceId,
        'facultyUid': facultyUid,
        'studentUid': studentUid,
        'departmentUid': departmentUid,
        'attendedOn': attendedOn.toIso8601String(),
        'isPresent': isPresent
      };

  static Future<bool> submitAttendanceDetails(List<Attendance> details) async {
    var uri = Endpoint.uri('/Student/TakeAttendance', queryParameters: {});

    var requestBody = json.encode(details);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: requestBody);

    if (response.statusCode != 200) return false;

    final Map<String, dynamic> decodedResponse = json.decode(response.body);
    return decodedResponse['isSuccess'];
  }
}
