import '../models/department.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

const departmentTileHeight = 100.0;

class DepartmentTile extends StatelessWidget {
  final Department department;
  final bool darkTheme;

  DepartmentTile({required this.department, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    final title = department.departmentName.toUpperCase();
    return Container(
      padding: const EdgeInsets.all(0.0),
      height: departmentTileHeight,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: darkTheme
                    ? Styles.departmentTileTitleDark
                    : Styles.departmentTileTitleLight)
          ]),
    );
  }
}
