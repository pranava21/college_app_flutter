import 'package:college_app/models/user.dart';
import 'package:college_app/providers/user_provider.dart';
import 'package:college_app/resources/authmethods.dart';
import 'package:college_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacultyLayout extends StatefulWidget {
  const FacultyLayout({Key? key}) : super(key: key);

  @override
  State<FacultyLayout> createState() => _FacultyLayoutState();
}

class _FacultyLayoutState extends State<FacultyLayout> {
  @override
  Widget build(BuildContext context) {
    UserDetails? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Text('${user?.userId}'),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () {
                AuthMethods().logOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Log Out')),
          Flexible(
            child: Container(),
            flex: 2,
          ),
        ],
      ),
    ));
  }
}
