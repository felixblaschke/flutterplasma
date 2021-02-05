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

  Dash({this.value});

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

class DashPainter extends CustomPainter {
  final double value;

  DashPainter({this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final dashFrame = paintDash(value);
    canvas.save();
    canvas.scale(size.width, size.height);
    canvas.drawPicture(dashFrame);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
