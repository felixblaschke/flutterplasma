import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final String text;
  final bool bold;
  final double textSize;

  LargeText(this.text, {@required this.textSize, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
    );
  }
}
