import 'package:college_app/models/user.dart';
import 'package:college_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserLayout extends StatefulWidget {
  final Widget studentLayout;
  final Widget facultyLayout;
  const UserLayout(
      {Key? key, required this.studentLayout, required this.facultyLayout})
      : super(key: key);

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
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
    return LayoutBuilder(builder: (context, constrains) {
      if (user != null) {
        if (user.isFaculty) {
          return widget.facultyLayout;
        } else if (user.isStudent) {
          return widget.studentLayout;
        }
      }
      return Container();
    });
  }
}
