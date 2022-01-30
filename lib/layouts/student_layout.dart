import 'dart:async';

import 'package:college_app/components/cards_tile.dart';
import 'package:college_app/models/user.dart';
import 'package:college_app/providers/user_provider.dart';
import 'package:college_app/widgets/student_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class StudentLayout extends StatefulWidget {
  const StudentLayout({Key? key}) : super(key: key);

  @override
  State<StudentLayout> createState() => _StudentLayoutState();
}

const double listItemHeight = 245.0;

class _StudentLayoutState extends State<StudentLayout> {
  late String _timeString;

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        //If using GoogleFont don't declare as constant
        title: Text('Dashboard', style: GoogleFonts.spartan()),
      ),
      drawer: StudentDrawer(user: user!),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(30, 25, 0, 10),
              child: Text('Hi there, ${user.firstName}!',
                  style: GoogleFonts.spartan(
                      fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(32, 0, 0, 20),
              child: Text(
                "It's $_timeString",
                style: GoogleFonts.spartan(fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
              child: Text(
                'Here are some reasons why you are lucky!',
                style: GoogleFonts.spartan(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 355,
              child: PageView(
                //scrollDirection: Axis.horizontal,
                controller: PageController(viewportFraction: 0.9),
                children: const [
                  CardsTile(
                    imagePath: 'assets/teachers.jpg',
                    title: 'Best in class teaching',
                    subtitle:
                        'You will receive the best learning in the world!',
                  ),
                  CardsTile(
                    imagePath: 'assets/labs.jpg',
                    title: 'Best in class labs',
                    subtitle:
                        'We offer state of the labs for your amazing projects!',
                  ),
                  CardsTile(
                    imagePath: 'assets/placement1.jpg',
                    title: 'Best in class placement',
                    subtitle: 'Consider yourself most employable person!',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    if (mounted) {
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE MMM dd, yyyy hh:mm:ss').format(dateTime);
  }
}
