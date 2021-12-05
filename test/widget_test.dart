// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import '../lib/models/department.dart';
import 'package:test/test.dart';

void main() {
  test('test /Department/GetAllDepartments', () async {
    final departments = await Department.fetchAllDepartments();

    for (var dept in departments) {
      expect(dept.departmentName, hasLength(greaterThan(0)));
    }
  });
}
