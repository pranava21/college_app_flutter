import 'package:college_app/models/faculty.dart';
import 'package:college_app/models/user.dart';
import 'package:college_app/resources/authmethods.dart';
import 'package:college_app/screens/faculty_screens/faculty_profile.dart';
import 'package:college_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FacultyDrawer extends StatelessWidget {
  final UserDetails user;
  const FacultyDrawer({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        key: key,
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.green])),
                  child: Text('Hi ${user.firstName}',
                      style: GoogleFonts.spartan(
                          color: Colors.white, fontSize: 25)),
                ),
                InkWell(
                  onTap: () async {
                    var faculty = await Faculty.fetchFacultyDetails(
                        user.emailId, user.departmentUid);
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FacultyProfile(user: user, faculty: faculty)));
                  },
                  child: ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Profile',
                          style: GoogleFonts.spartan(fontSize: 17),
                        ),
                      )),
                ),
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Divider(
                    thickness: 0.7,
                    color: Colors.grey[300],
                  ),
                  InkWell(
                    onTap: () {
                      AuthMethods().logOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: ListTile(
                        leading: const Icon(Icons.power_settings_new_outlined),
                        title: Text(
                          'Log Out',
                          style: GoogleFonts.spartan(fontSize: 16),
                        )),
                  ),
                  const SizedBox(
                    height: 9,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
