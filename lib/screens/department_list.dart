import 'package:flutter/material.dart';
import 'package:college_app/models/department.dart';

class DepartmentList extends StatefulWidget {
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
        appBar: AppBar(title: Text("List of Departments")),
        body: RefreshIndicator(
            onRefresh: loadDepartments,
            child: Column(
              children: [
                renderProgressBar(context),
                renderDepartmentList(context)
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
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }

  Widget renderItemBuilder(BuildContext context, int index) {
    final department = this._departments[index];
    return ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        title: Text(department.departmentName));
  }
}
