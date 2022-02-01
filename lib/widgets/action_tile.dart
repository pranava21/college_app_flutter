import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final String imagePath;
  final String route;
  const ActionTile(
      {Key? key,
      required this.name,
      required this.subtitle,
      required this.imagePath,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
            child: InkWell(
                child: _tileImage(imagePath),
                onTap: () => _navigateToAction(context))),
        ListTile(
            title: Text(name),
            subtitle: Text(subtitle),
            onTap: () => _navigateToAction(context)),
      ],
    ));
  }

  void _navigateToAction(BuildContext context) {
    //Navigator.pushNamed(context, route);
  }

  Widget _tileImage(String imagePath) {
    if (imagePath.isEmpty) {
      return Container();
    }

    try {
      return SvgPicture.asset(imagePath, height: 200,);
    } catch (e) {
      // ignore: avoid_print
      print("could not load image $imagePath");
      return Container();
    }
  }
}
