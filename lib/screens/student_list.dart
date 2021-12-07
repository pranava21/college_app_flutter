import 'package:flutter/material.dart';
import 'package:college_app/models/student.dart';

import '../styles.dart';

const personIcon = Icon(Icons.person);

class StudentList extends StatefulWidget {
  final String departmentUid;

  StudentList(this.departmentUid);

  @override
  createState() => _StudentListState(departmentUid);
}

class _StudentListState extends State<StudentList> {
  List<Student> students = [];
  bool loading = false;
  final String departmentUid;

  _StudentListState(this.departmentUid);

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Student List", style: Styles.navBarTitle)),
        body: RefreshIndicator(
            onRefresh: loadStudents,
            child: Column(children: [
              renderProgressBar(context),
              Expanded(child: renderStudentListView(context)),
            ])));
  }

  Future<void> loadStudents() async {
    if (this.mounted) {
      setState(() => this.loading = true);

      final students =
          await Student.fetchStudentsByDepartment(this.departmentUid);

      setState(() {
        this.students = students;
        this.loading = false;
      });
    }
  }

  Widget renderProgressBar(BuildContext context) {
    return (this.loading
        ? const CircularProgressIndicator(
            backgroundColor: Colors.white, color: Colors.blue)
        : Container());
  }

  Widget renderStudentListView(BuildContext context) {
    return ListView.builder(
      itemCount: this.students.length,
      itemBuilder: _listViewItemBuilder,
      shrinkWrap: true,
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final student = students[index];
    var name = student.studentName;
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: personIcon,
          title: Text(student.studentName),
          subtitle: Text(student.studentEmail),
        ),
      ],
    ));
  }
}
