import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppText(
      {super.key, required this.size, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.mavenPro(
        fontSize: size,
        color: color,
      ),
    );
  }
}
