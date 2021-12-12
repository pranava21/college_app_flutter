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
