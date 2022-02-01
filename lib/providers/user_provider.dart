import 'package:college_app/models/user.dart';
import 'package:college_app/resources/authmethods.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserDetails? _user;

  UserDetails? get getUser => _user;

  Future<void> refreshUser() async {
    UserDetails? user = await AuthMethods().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
