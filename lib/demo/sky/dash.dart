import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'dash_painter.dart';

class DashAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<double>(
        tween: 0.0.tweenTo(1.0),
        duration: 300.milliseconds,
        builder: (context, child, value) {
          return Dash(value: value);
        });
  }
}

class Dash extends StatelessWidget {
  final double value;

  const Dash({required this.value});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        child: CustomPaint(
          painter: DashPainter(value: value),
        ),
      ),
    );
  }
}

final Paint opaque = Paint()..filterQuality = FilterQuality.medium;

class DashPainter extends CustomPainter {
  final double value;

  const DashPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final dashFrame = paintDash(value);
    final scale = size.width / dashWidth;

    final rstTransforms = Float32List(4);
    rstTransforms[0] = scale;

    final rects = Float32List(4);
    rects[0] = 0;
    rects[1] = 0;
    rects[2] = dashWidth;
    rects[3] = dashHeight;

    canvas.drawRawAtlas(
      dashFrame,
      rstTransforms,
      rects,
      null,
      BlendMode.srcOver,
      null,
      opaque,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MultiDashPainter extends CustomPainter {
  const MultiDashPainter(this.otherDashes, this.value);

  final double otherDashes;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(18);
    final randomAngle = Random(16);

    const dashCount = 20;
    final rstTransforms = Float32List(4 * dashCount);
    final rects = Float32List(4 * dashCount);

    0.until(dashCount).forEach((n) {
      final offset = 4 * n;
      rects[offset + 2] = dashWidth;
      rects[offset + 3] = dashHeight;

      var left = 0.0 + 1.0 * random.nextDouble() + (1 - otherDashes) * 0.3;
      left *= size.width;
      var top = 2.4 * (1 - otherDashes) - 1.2 + random.nextDouble();
      top *= size.height;
      var length = 0.14 + 0.08 * random.nextDouble() - otherDashes * 0.1;
      length *= size.width;
      final scale = length / dashWidth;

      final anchorX = dashWidth / 2;
      final anchorY = dashHeight / 2;
      final rotation = 0.3 + 0.2 * randomAngle.nextDouble();
      final scos = cos(rotation) * scale;
      final ssin = sin(rotation) * scale;
      final tx = left + -scos * anchorX + ssin * anchorY;
      final ty = top + -ssin * anchorX - scos * anchorY;

      rstTransforms[offset] = scos;
      rstTransforms[offset + 1] = ssin;
      rstTransforms[offset + 2] = tx;
      rstTransforms[offset + 3] = ty;
    });

    final dashFrame = paintDash(value);
    canvas.clipRect(Offset.zero & size);
    canvas.drawRawAtlas(
      dashFrame,
      rstTransforms,
      rects,
      null,
      BlendMode.srcOver,
      null,
      opaque,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
