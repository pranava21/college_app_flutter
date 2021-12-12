import 'package:college_app/screens/add_student.dart';
import 'package:college_app/screens/department_list.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ActionList());
  }
}

class ActionList extends StatelessWidget {
  final List<String> _listOfActions = ["View Students", "Add a new Student"];
  var departmentUrl =
      'https://cdn1.iconfinder.com/data/icons/university-indigo-vol-1/256/Department-512.png';
  var studentUrl =
      'https://cdn2.iconfinder.com/data/icons/school-flat-circle/512/Boy_child_school_boy_student-512.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("College App")),
        body: renderActionsListView(context));
  }

  Widget renderActionsListView(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Card(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: GestureDetector(
                    child: Expanded(
                        child: Image.network(departmentUrl, fit: BoxFit.cover)),
                    onTap: () => _navigateToDepartmentList(context))),
            ListTile(
                title: Text(_listOfActions[0]),
                subtitle: const Text('View Students by deparment'),
                onTap: () => _navigateToDepartmentList(context)),
          ],
        )),
        Card(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: GestureDetector(
                    child: Expanded(
                        child: Image.network(studentUrl, fit: BoxFit.cover)),
                    onTap: () => _navigateToAddStudentForm(context))),
            ListTile(
              title: Text(_listOfActions[1]),
              subtitle: const Text('Add a new student'),
              onTap: () => _navigateToAddStudentForm(context),
            ),
          ],
        )),
      ],
    );
  }

  void _navigateToDepartmentList(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DepartmentList()));
  }

  void _navigateToAddStudentForm(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddStudent()));
  }
}
