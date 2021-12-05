import '../models/department.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

const DepartmentTileHeight = 100.0;

class DepartmentTile extends StatelessWidget {
  final Department department;
  final bool darkTheme;

  DepartmentTile({required this.department, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    final title = department.departmentName.toUpperCase();
    return Container(
      padding: EdgeInsets.all(0.0),
      height: DepartmentTileHeight,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: this.darkTheme
                    ? Styles.departmentTileTitleDark
                    : Styles.departmentTileTitleLight)
          ]),
    );
  }
}
