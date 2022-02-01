import 'package:flutter/material.dart';
import 'package:college_app/models/student.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

const personIcon = Icon(Icons.person);

class StudentList extends StatefulWidget {
  final String departmentUid;

  const StudentList(this.departmentUid, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
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
        appBar:
            AppBar(title: Text("Student List", style: GoogleFonts.spartan())),
        body: RefreshIndicator(
            onRefresh: loadStudents,
            child: students.isEmpty
                ? Center(
                    child: SvgPicture.asset(
                      'assets/discontinued_product.svg',
                      height: 100,
                    ),
                  )
                : Column(children: [
                    renderProgressBar(context),
                    Expanded(child: renderStudentListView(context)),
                  ])));
  }

  Future<void> loadStudents() async {
    if (mounted) {
      setState(() => loading = true);

      final students = await Student.fetchStudentsByDepartment(departmentUid);

      setState(() {
        this.students = students;
        loading = false;
      });
    }
  }

  Widget renderProgressBar(BuildContext context) {
    return (loading
        ? const CircularProgressIndicator(
            backgroundColor: Colors.white, color: Colors.blue)
        : Container());
  }

  Widget renderStudentListView(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: _listViewItemBuilder,
      shrinkWrap: true,
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final student = students[index];
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: personIcon,
          title: Text(student.studentFirstName, style: GoogleFonts.spartan()),
          subtitle: Text(student.studentEmail, style: GoogleFonts.spartan()),
        ),
      ],
    ));
  }
}
