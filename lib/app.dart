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
  final List<String> _listOfActions = [
    "View All Departments",
    "Add a new Student"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("College App")),
        body: renderActionsListView(context));
  }

  Widget renderActionsListView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.all(10.0),
          title: Center(child: Text(_listOfActions[0])),
          tileColor: Colors.amber[600],
          onTap: () => _navigateToDepartmentList(context),
        ),
        ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            title: Center(child: Text(_listOfActions[1])),
            tileColor: Colors.amber[300])
      ],
    );
  }

  void _navigateToDepartmentList(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DepartmentList()));
  }
}
