import 'dart:developer' as developer;
import 'package:college_app/models/department.dart';
import 'package:college_app/models/faculty.dart';
import 'package:college_app/screens/take_attendance.dart';
import 'package:flutter/material.dart';

class SelectClass extends StatefulWidget {
  const SelectClass({Key? key}) : super(key: key);

  @override
  _SelectClassState createState() => _SelectClassState();
}

class _SelectClassState extends State<SelectClass> {
  final _formKey = GlobalKey<FormState>();
  List<Department> _departments = [];
  List<Faculty> _faculties = [];
  bool isLoading = false;

  String departmentDropDownValue = '';
  String selectedDepartmentUid = '';

  String facultyDropDownValue = '';
  String selectedFacultyUid = '';

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Take Attendance')),
        body: SingleChildScrollView(
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        renderDepartmentsDropDown(context),
                        addSpacingWidget(),
                        renderFacultiesDropDown(),
                        addSpacingWidget(),
                        renderSubmitButton(context)
                      ],
                    )),
              )),
        ));
  }

  Future<void> loadDepartments() async {
    if (mounted) {
      setState(() => isLoading = true);
      final departments = await Department.fetchAllDepartments();

      setState(() {
        _departments = departments;
        departmentDropDownValue = _departments.first.departmentName;
        selectedDepartmentUid = _departments.first.departmentUid;
        loadFaculties();
        isLoading = false;
      });
    }
  }

  Widget renderDepartmentsDropDown(BuildContext context) {
    return InputDecorator(
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Department',
            labelStyle: TextStyle(fontSize: 20.0)),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: departmentDropDownValue,
          style: const TextStyle(color: Colors.blue, fontSize: 16.0),
          iconEnabledColor: Colors.black,
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              departmentDropDownValue = newValue!;
              _setSelectedDepartmentUid(departmentDropDownValue);
              loadFaculties();
            });
          },
          items: _departments
              .map<DropdownMenuItem<String>>((Department department) {
            return DropdownMenuItem<String>(
              value: department.departmentName,
              child: Text(department.departmentName),
            );
          }).toList(),
          hint: const Text(
            "Please choose your department",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          borderRadius: BorderRadius.circular(10.0),
          isExpanded: true,
        )));
  }

  void _setSelectedDepartmentUid(String departmentName) {
    var dept = _departments
        .where((element) => element.departmentName == departmentName)
        .toList();

    selectedDepartmentUid = dept.first.departmentUid;
  }

  Future<void> loadFaculties() async {
    selectedFacultyUid = '';
    //facultyDropDownValue = '';
    final faculties =
        await Faculty.getFacultyDetailsByDepartment(selectedDepartmentUid);

    setState(() {
      _faculties = faculties;
      selectedFacultyUid = _faculties.first.facultyUid;
      facultyDropDownValue = _faculties.first.firstName;
    });
  }

  Widget renderFacultiesDropDown() {
    return InputDecorator(
        //key: ValueKey<List<Faculty>>(_faculties),
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Faculty',
            labelStyle: TextStyle(fontSize: 20.0)),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
          value: facultyDropDownValue,
          style: const TextStyle(color: Colors.blue, fontSize: 16.0),
          iconEnabledColor: Colors.black,
          underline: Container(
            height: 2,
            color: Colors.blueAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              facultyDropDownValue = newValue!;
              _setSelectedFacultyUid(facultyDropDownValue);
            });
          },
          items: _faculties.map<DropdownMenuItem<String>>((Faculty faculty) {
            return DropdownMenuItem<String>(
              value: faculty.firstName,
              child: Text(faculty.firstName),
            );
          }).toList(),
          hint: const Text(
            "Please choose your respective name",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          borderRadius: BorderRadius.circular(10.0),
          isExpanded: true,
        )));
  }

  void _setSelectedFacultyUid(String facultyName) {
    var faculty =
        _faculties.where((element) => element.firstName == facultyName).toList();
    selectedFacultyUid = faculty.first.facultyUid;
  }

  Widget addSpacingWidget() {
    return const SizedBox(height: 20);
  }

  Widget renderSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final form = _formKey.currentState;
        if (form!.validate()) {
          form.save();
          _navigateToTakeAttendancePage(
              context, selectedDepartmentUid, selectedFacultyUid);
        }
      },
      child: const Text(
        'Submit',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  _navigateToTakeAttendancePage(
      BuildContext context, String departmentUid, String facultyUid) {
    developer.log("Selected Faculty: " + facultyUid);
    developer.log("Selected Department: " + departmentUid);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TakeAttendance(departmentUid, facultyUid)));
  }
}
