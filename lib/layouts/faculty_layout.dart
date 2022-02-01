import 'dart:async';

import 'package:college_app/components/cards_tile.dart';
import 'package:college_app/models/user.dart';
import 'package:college_app/providers/user_provider.dart';
import 'package:college_app/widgets/actions_list.dart';
import 'package:college_app/widgets/faculty_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FacultyLayout extends StatefulWidget {
  const FacultyLayout({Key? key}) : super(key: key);

  @override
  State<FacultyLayout> createState() => _FacultyLayoutState();
}

class _FacultyLayoutState extends State<FacultyLayout> {
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
      drawer: FacultyDrawer(user: user!),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(30, 25, 0, 10),
              child: Text('Hello, ${user.firstName}!',
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
            Divider(
              thickness: 0.7,
              color: Colors.grey[300],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
              child: Text(
                'Here are some reasons why you are lucky',
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
                    imagePath: 'assets/lab.jpg',
                    title: 'Excellent Labs',
                    subtitle:
                        'We have well funded labs for all your projects and experiments',
                  ),
                  CardsTile(
                    imagePath: 'assets/staffroom.jpg',
                    title: 'State of the art staffroom',
                    subtitle:
                        'Relax in your free time in our extremely comfortable staffrooms',
                  ),
                  CardsTile(
                    imagePath: 'assets/gym.jpg',
                    title: 'State of the art gym',
                    subtitle:
                        'You can use the college gym for free as our compliments',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            Divider(
              thickness: 0.7,
              color: Colors.grey[300],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
              child: Text(
                'What do you like to do today?',
                style: GoogleFonts.spartan(fontSize: 14),
              ),
            ),
            const ActionList()
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
