import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final String text;
  final bool bold;
  final double textSize;

  const LargeText(this.text, {required this.textSize, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Work Sans',
          color: Colors.white,
          fontSize: textSize,
          fontWeight: !bold ? FontWeight.w200 : FontWeight.w600),
    );
  }
}
