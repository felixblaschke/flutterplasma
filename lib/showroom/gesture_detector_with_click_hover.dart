import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GestureDetectorWithClickHover extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;

  const GestureDetectorWithClickHover(
      {required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
