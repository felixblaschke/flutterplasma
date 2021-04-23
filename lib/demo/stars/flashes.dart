import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class Flashes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomPaint(
        painter: _Painter(),
      );
    });
  }
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(7);
    3.times(() {
      var position = Offset(
        (0.1 + 0.6 * random.nextDouble()) * size.width,
        (0.1 + 0.4 * random.nextDouble()) * size.height,
      );

      final paint = Paint()
        ..strokeWidth = size.width * 0.1 * (1 + 0.1 * random.nextDouble())
        ..blendMode = BlendMode.srcOver
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20)
        ..color = Color(0xFFD987EB).withOpacity(0.3 * random.nextDouble());

      (2 + random.nextInt(6)).times(() {
        final target = Offset(
          position.dx + random.nextDouble() * size.width * 0.07,
          position.dy + random.nextDouble() * size.height * 0.07,
        );
        canvas.drawLine(position, target, paint);
        position = target;
      });
    });
  }

  @override
  bool shouldRepaint(covariant _Painter oldDelegate) {
    return false;
  }
}
