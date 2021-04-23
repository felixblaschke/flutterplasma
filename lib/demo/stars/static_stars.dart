import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class StaticStars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final n = min(
          1000, (constraints.maxWidth * constraints.maxHeight / 2000).round());

      return CustomPaint(
        painter: _Painter(n: n),
      );
    });
  }
}

class _Painter extends CustomPainter {
  final int n;

  _Painter({required this.n});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(1);
    n.times(() {
      final position = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );
      final radius = 2 * random.nextDouble();
      final paint = Paint()
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1)
        ..color = colors.pickOne(random).withOpacity(0.7 * random.nextDouble());
      canvas.drawCircle(position, radius, paint);
    });
  }

  @override
  bool shouldRepaint(covariant _Painter oldDelegate) {
    return oldDelegate.n != n;
  }
}

var colors = [
  '#DAB6BA'.toColor(),
  '#FFDFFF'.toColor(),
  '#878DEB'.toColor(),
];
