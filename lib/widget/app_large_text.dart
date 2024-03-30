import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  AppLargeText(
      {super.key, required this.size, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.anton(
        fontSize: size,
        color: color,
      ),
    );
  }
}
