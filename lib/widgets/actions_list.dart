import 'package:college_app/widgets/action_tile.dart';
import 'package:flutter/material.dart';
import 'package:college_app/utils/routes.dart' as route;

class ActionList extends StatelessWidget {
  final String departmentImagePath = 'assets/department.png';
  final String studentImagePath = 'assets/students.png';
  final String attendanceUrl = 'assets/calendar.png';

  const ActionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: const <Widget>[
          ActionTile(
              name: "View Students",
              subtitle: 'View Students by deparment',
              imagePath: 'assets/college.svg',
              route: route.departmentList),
          ActionTile(
              name: "Add student",
              subtitle: 'Add a new student',
              imagePath: 'assets/classmate.svg',
              route: route.addStudent),
          ActionTile(
              name: "Take Attendance",
              subtitle: 'Mark attendance for students',
              imagePath: 'assets/attendance_list.svg',
              route: route.selectClass),
        ],
      ),
    );
  }
}
