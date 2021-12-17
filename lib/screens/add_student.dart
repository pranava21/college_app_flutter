import 'package:college_app/models/add_student_model.dart';
import 'package:college_app/screens/student_list.dart';
import 'package:flutter/material.dart';
import 'package:college_app/models/department.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/student.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  final student = Student.blank();
  List<Department> departments = [];
  String dropDownValue = '';
  String selectedDepartmentUid = '';
  String address = '';

  @override
  initState() {
    super.initState();
    loadDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add Student')),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Builder(
                  builder: (context) => Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                },
                                onSaved: (value) => setState(() =>
                                    student.studentName = value.toString())),
                            const SizedBox(height: 20),
                            TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email ID'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email id';
                                  }
                                },
                                onSaved: (value) => setState(() =>
                                    student.studentEmail = value.toString())),
                            const SizedBox(height: 20),
                            TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Phone Number'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                },
                                onSaved: (value) => setState(
                                    () => student.phoneNo = value.toString())),
                            const SizedBox(height: 20),
                            TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Address'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your address';
                                  }
                                },
                                onSaved: (value) =>
                                    setState(() => address = value.toString())),
                            const SizedBox(height: 25),
                            InputDecorator(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Department',
                                    labelStyle: TextStyle(fontSize: 20.0)),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  value: dropDownValue,
                                  style: const TextStyle(
                                      color: Colors.blue, fontSize: 16.0),
                                  iconEnabledColor: Colors.black,
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blueAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropDownValue = newValue!;
                                      _SetSelectedDepartmentUid(dropDownValue);
                                    });
                                  },
                                  items: departments
                                      .map<DropdownMenuItem<String>>(
                                          (Department department) {
                                    return DropdownMenuItem<String>(
                                      value: department.departmentName,
                                      child: Text(department.departmentName),
                                    );
                                  }).toList(),
                                  hint: const Text(
                                    "Please choose your department",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  isExpanded: true,
                                ))),
                            const SizedBox(height: 100),
                            ElevatedButton(
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  submitStudentDetails(student, dropDownValue,
                                      selectedDepartmentUid);
                                }
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ])),
                ))));
  }

  Future<void> loadDepartments() async {
    final departmentList = await Department.fetchAllDepartments();

    setState(() {
      departments = departmentList;
      dropDownValue = departments.first.departmentName;
      selectedDepartmentUid = departments.first.departmentUid;
    });
  }

  Future<void> submitStudentDetails(
      Student student, String deparmentName, String departmentUid) async {
    student.departmentName = deparmentName;
    student.departmentUid = departmentUid;

    AddStudentModel addStudentModel = AddStudentModel(
        student.studentName,
        student.studentEmail,
        student.phoneNo,
        address,
        departmentUid,
        student.departmentName);

    var response = await Student.AddStudent(addStudentModel);

    if (response) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Success",
        desc: "Student added successfully!",
        buttons: [
          DialogButton(
            child: const Text("Go to Student List",
                style: TextStyle(color: Colors.white, fontSize: 18),
                textWidthBasis: TextWidthBasis.longestLine),
            onPressed: () => _navigateToStudentList(context, departmentUid),
            width: 200,
          )
        ],
      ).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Sorry",
        desc: "Something went wrong",
        buttons: [
          DialogButton(
            child: const Text(
              "Back",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 200,
          )
        ],
      ).show();
    }
  }

  // ignore: non_constant_identifier_names
  void _SetSelectedDepartmentUid(String departmentName) {
    var dept = departments
        .where((element) => element.departmentName == departmentName)
        .toList();

    selectedDepartmentUid = dept.first.departmentUid;
  }

  _navigateToStudentList(BuildContext context, String departmentUid) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => StudentList(departmentUid)));
  }
}
