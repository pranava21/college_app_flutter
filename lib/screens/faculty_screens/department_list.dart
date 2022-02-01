// ignore_for_file: unnecessary_this

import 'package:college_app/components/department_tile.dart';
import 'package:flutter/material.dart';
import 'package:college_app/models/department.dart';
import 'package:google_fonts/google_fonts.dart';
import '../student_screens/student_list.dart';

const double listItemHeight = 245.0;

class DepartmentList extends StatefulWidget {
  const DepartmentList({Key? key}) : super(key: key);

  @override
  createState() => _DepartmentListState();
}

class _DepartmentListState extends State<DepartmentList> {
  List<Department> _departments = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("List of Departments", style: GoogleFonts.spartan())),
        body: RefreshIndicator(
            onRefresh: loadDepartments,
            child: Column(
              children: [
                renderProgressBar(context),
                Expanded(child: renderDepartmentList(context))
              ],
            )));
  }

  Future<void> loadDepartments() async {
    if (this.mounted) {
      setState(() => this.loading = true);
      final departments = await Department.fetchAllDepartments();

      setState(() {
        this._departments = departments;
        this.loading = false;
      });
    }
  }

  Widget renderProgressBar(BuildContext context) {
    return (this.loading
        ? const LinearProgressIndicator(
            value: null,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          )
        : Container());
  }

  Widget renderDepartmentList(BuildContext context) {
    return ListView.builder(
      itemCount: this._departments.length,
      itemBuilder: renderItemBuilder,
      shrinkWrap: true,
    );
  }

  Widget renderItemBuilder(BuildContext context, int index) {
    final department = this._departments[index];
    return GestureDetector(
        onTap: () => _navigateToStudentList(context, department.departmentUid),
        child: SizedBox(
            height: listItemHeight,
            child: Stack(children: [
              _tileImage(department.departmentImageUrl,
                  MediaQuery.of(context).size.width, listItemHeight),
              _tileFooter(department)
            ])));
  }

  Widget _tileImage(String url, double width, double height) {
    if (url.isEmpty) {
      return Container();
    }

    try {
      return Container(
        constraints: const BoxConstraints.expand(),
        child: Image.network(url, fit: BoxFit.cover),
      );
    } catch (e) {
      // ignore: avoid_print
      print("could not load image $url");
      return Container();
    }
  }

  Widget _tileFooter(Department department) {
    final info = DepartmentTile(department: department, darkTheme: true);
    final overlay = Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }

  _navigateToStudentList(BuildContext context, String departmentUid) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => StudentList(departmentUid)));
  }
}
