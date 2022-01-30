import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double listItemHeight = 245.0;

class CardsTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  const CardsTile({Key? key, required this.imagePath, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      height: 330,
      width: double.maxFinite,
      child: Card(
          semanticContainer: true,
          elevation: 10,
          child: Column(
            children: [
              _tileImage(
                  path: imagePath,
                  width: MediaQuery.of(context).size.width,
                  height: listItemHeight),
              //const SizedBox(height: 7,),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                title: Text(title, style: GoogleFonts.spartan(),),
                subtitle: Text(subtitle, style: GoogleFonts.spartan(),),
              )
            ],
          )),
    );
  }

  Widget _tileImage(
      {required String path, required double width, required double height}) {
    try {
      return Container(
        constraints: BoxConstraints.expand(width: width, height: height),
        child: Image.asset(path, fit: BoxFit.fill),
      );
    } catch (e) {
      // ignore: avoid_print
      print("could not load image $path");
      return Container();
    }
  }
}
