import 'package:college_app/screens/add_student.dart';
import 'package:college_app/screens/department_list.dart';
import 'package:college_app/screens/select_class.dart';
import 'package:flutter/material.dart';


  // variable for our route names
  const String departmentList = 'department_list';
  const String addStudent = 'add_student';
  const String selectClass = 'select_class';

  // controller function with switch statement to control page route flow
  Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case departmentList:
        return MaterialPageRoute(builder: (context) => const DepartmentList());
      case addStudent:
        return MaterialPageRoute(builder: (context) => const AddStudent());
      case selectClass:
        return MaterialPageRoute(builder: (context) => const SelectClass());
      default:
        throw ('this route name does not exist');
    }
  }