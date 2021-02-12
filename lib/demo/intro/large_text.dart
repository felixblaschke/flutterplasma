import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeText extends StatelessWidget {
  final String text;
  final bool bold;
  final double textSize;

  LargeText(this.text, {required this.textSize, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.workSans(
          color: Colors.white,
          fontSize: textSize,
          fontWeight: !bold ? FontWeight.w200 : FontWeight.w600),
    );
  }
}
