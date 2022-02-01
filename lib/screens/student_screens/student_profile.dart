import 'package:college_app/models/student.dart';
import 'package:college_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentProfile extends StatelessWidget {
  final UserDetails user;
  final Student student;

  const StudentProfile({Key? key, required this.user, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile', style: GoogleFonts.spartan()),
          ),
          body: Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: SvgPicture.asset(
                        'assets/student_little_boy.svg',
                        height: 150,
                      )),
                  Card(
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Text('${user.firstName} ${user.lastName}',
                              style: GoogleFonts.spartan(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Text('Student ID: ${student.studentId}',
                              style: GoogleFonts.spartan(
                                fontSize: 15,
                              )),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Text('Email ID: ${student.studentEmail}',
                              style: GoogleFonts.spartan(
                                fontSize: 15,
                              )),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Text('Mobile: ${student.phoneNo}',
                              style: GoogleFonts.spartan(
                                fontSize: 15,
                              )),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Text(student.departmentName,
                              style: GoogleFonts.spartan(
                                fontSize: 15,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 20, left: 30),
                    child: Text('Home Address',
                        style: GoogleFonts.spartan(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Card(
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 20, left: 30),
                          child: Text(user.address,
                              style: GoogleFonts.spartan(
                                fontSize: 15,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
