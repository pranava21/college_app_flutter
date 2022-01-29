import 'package:college_app/models/user.dart';
import 'package:college_app/providers/user_provider.dart';
import 'package:college_app/resources/authmethods.dart';
import 'package:college_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentLayout extends StatefulWidget {
  StudentLayout({Key? key}) : super(key: key);

  @override
  State<StudentLayout> createState() => _StudentLayoutState();
}

class _StudentLayoutState extends State<StudentLayout> {
  @override
  void initState() {
    super.initState();
    addUserData();
  }

  addUserData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

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
