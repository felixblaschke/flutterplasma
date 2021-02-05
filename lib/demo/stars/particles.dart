import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class ParticlesPainter extends CustomPainter {
  final double value;

  ParticlesPainter({this.value});

  @override
  void paint(Canvas canvas, Size size) {
    var random = Random(1);

    200.times(() {
      var start = random.nextDouble();
      var p = (start + value) % 1.0;

      var target = random.nextBool()
          ? Offset(
              random.nextDouble(),
              random.nextBool() ? -0.0 : 1.0,
            )
          : Offset(
              random.nextBool() ? -0.0 : 1.0,
              random.nextDouble(),
            );

      var position = Offset(
        ((1 - p) * 0.5 + p * target.dx) * size.width,
        ((1 - p) * 0.5 + p * target.dy) * size.height,
      );

      var paint = Paint()..color = Colors.white.withOpacity(0.3 + 0.4 * p);

      if (p > 0.1) {
        canvas.drawCircle(position, size.width * 0.002 * p, paint);
      }
    });
  }

  @override
  bool shouldRepaint(covariant ParticlesPainter oldDelegate) {
    return value != oldDelegate.value;
  }
}
