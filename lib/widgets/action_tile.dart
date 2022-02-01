import 'package:college_app/models/attendance_args.dart';
import 'package:college_app/models/faculty.dart';
import 'package:college_app/models/user.dart';
import 'package:college_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:college_app/utils/routes.dart' as routes;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ActionTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final String imagePath;
  final String route;
  const ActionTile(
      {Key? key,
      required this.name,
      required this.subtitle,
      required this.imagePath,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
            child: InkWell(
                child: _tileImage(imagePath),
                onTap: () => _navigateToAction(context))),
        ListTile(
            title: Text(name, style: GoogleFonts.spartan()),
            subtitle: Text(subtitle, style: GoogleFonts.spartan()),
            onTap: () => _navigateToAction(context)),
      ],
    ));
  }

  void _navigateToAction(BuildContext context) async {
    if (route == routes.takeAttendance) {
      UserDetails? user =
          Provider.of<UserProvider>(context, listen: false).getUser;
      if (user != null) {
        Faculty faculty =
            await Faculty.fetchFacultyDetails(user.emailId, user.departmentUid);
        Navigator.pushNamed(context, route,
            arguments: AttendanceArgs(user.departmentUid, faculty.facultyUid));
      }
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  Widget _tileImage(String imagePath) {
    if (imagePath.isEmpty) {
      return Container();
    }

    try {
      return SvgPicture.asset(
        imagePath,
        height: 200,
      );
    } catch (e) {
      // ignore: avoid_print
      print("could not load image $imagePath");
      return Container();
    }
  }
}
