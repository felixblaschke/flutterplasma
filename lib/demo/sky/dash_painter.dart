import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:supercharged/supercharged.dart';

final bodyPaint = Paint()..color = '#68BDFE'.toColor();
final breastPaint = Paint()..color = '#ffffff'.toColor();
final nosePaint = Paint()..color = '#725D48'.toColor();
final eyesOuterPaint = Paint()..color = '#1D90F9'.toColor();
final eyesInnerPaint = Paint()..color = '#070711'.toColor();
final eyesReflectionPaint = Paint()..color = '#ffffff'.toColor();
final tailPaint = Paint()..color = '#0E2D7D'.toColor();

/// Paints one frame of animated Dash.
///
/// The animation position is determined by [value], which is expected to take
/// values between 0.0 and 1.0.
ui.Image paintDash(double value) {
  assert(0.0 <= value && value <= 1.0);
  return _frames[(value * _framesPerAnimationCycle).toInt()];
}

const int _framesPerAnimationCycle = 10;

late final List<ui.Image> _frames;

const dashWidth = 500.0;
const dashHeight = 500.0;
const dashSize = Size(dashWidth, dashHeight);

Future<void> initializeDashPainter() async {
  final frames = <ui.Image>[];
  for (var i = 0; i < _framesPerAnimationCycle; i++) {
    frames.add(await _paintOneFrame(i / _framesPerAnimationCycle)
        .toImage(dashWidth.toInt(), dashHeight.toInt()));
  }
  _frames = frames;
}

ui.Picture _paintOneFrame(double value) {
  const cullRect = Rect.fromLTRB(0, 0, dashWidth, dashHeight);

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder, cullRect);
  var feetPaint = Paint()
    ..strokeWidth = dashWidth * 0.01
    ..strokeCap = StrokeCap.round
    ..color = '#725D48'.toColor();

  // Left feet
  var leftFeetStart = Offset(dashWidth * 0.53, dashHeight * 0.75);
  var leftFeetVec =
      Offset(dashWidth * (0.01 + value * 0.02), dashHeight * 0.08);
  var leftFeetMiddle = Offset(
      leftFeetStart.dx + leftFeetVec.dx, leftFeetStart.dy + leftFeetVec.dy);
  canvas.drawLine(leftFeetStart, leftFeetMiddle, feetPaint);
  canvas.drawLine(
      leftFeetMiddle,
      Offset(leftFeetMiddle.dx + dashWidth * -0.02,
          leftFeetMiddle.dy + dashHeight * 0.05),
      feetPaint);
  canvas.drawLine(
      leftFeetMiddle,
      Offset(leftFeetMiddle.dx + dashWidth * 0,
          leftFeetMiddle.dy + dashHeight * 0.06),
      feetPaint);
  canvas.drawLine(
      leftFeetMiddle,
      Offset(leftFeetMiddle.dx + dashWidth * 0.02,
          leftFeetMiddle.dy + dashHeight * 0.05),
      feetPaint);

  // Tail
  final tailPath = Path()
    ..moveTo(dashWidth * 0.55, dashHeight * 0.6)
    ..lineTo(dashWidth * 0.75, dashHeight * 0.55)
    ..quadraticBezierTo(
        dashWidth * 0.95, dashHeight * 0.55, dashWidth * 0.9, dashHeight * 0.6)
    ..quadraticBezierTo(
        dashWidth * 0.95, dashHeight * 0.65, dashWidth * 0.9, dashHeight * 0.68)
    ..quadraticBezierTo(
        dashWidth * 0.95, dashHeight * 0.75, dashWidth * 0.9, dashHeight * 0.75)
    ..close();
  canvas.drawPath(tailPath, tailPaint);

  // Body
  final bodyOval = Rect.fromCenter(
      center: dashSize.center(Offset.zero),
      width: dashWidth / (2.2 - 0.03 * value),
      height: dashHeight / (2 - 0.03 * value));
  canvas.drawOval(bodyOval, bodyPaint);

  // Breast
  canvas.save();
  canvas.clipPath(Path()..addOval(bodyOval));

  final breastOval = Rect.fromCenter(
      center: dashSize.center(Offset(-0.07 * dashWidth, 0.15 * dashHeight)),
      width: dashWidth / 3,
      height: dashHeight / 3);
  canvas.drawOval(breastOval, breastPaint);
  canvas.restore();

  // Breast color
  canvas.drawOval(
      Rect.fromCenter(
          center: dashSize.center(Offset(
            dashWidth * -0.05,
            dashHeight * -0.07,
          )),
          width: dashWidth / 3.8,
          height: dashHeight / 3),
      bodyPaint);

  // Eyes Outer
  final leftEyeOval = Rect.fromCenter(
      center: dashSize.center(Offset(-0.1 * dashWidth, -0.05 * dashHeight)),
      width: dashWidth / 6,
      height: dashHeight / 5);
  canvas.drawOval(leftEyeOval, eyesOuterPaint);

  final rightEyeOval = Rect.fromCenter(
      center: dashSize.center(Offset(0 * dashWidth, -0.05 * dashHeight)),
      width: dashWidth / 6,
      height: dashHeight / 5);
  canvas.drawOval(rightEyeOval, eyesOuterPaint);

  // Eyes Inner
  final leftEyeInnerOval = Rect.fromCenter(
      center: dashSize.center(Offset(-0.1 * dashWidth, -0.05 * dashHeight)),
      width: dashWidth / 12,
      height: dashHeight / 8);
  canvas.drawOval(leftEyeInnerOval, eyesInnerPaint);

  final rightEyeInnerOval = Rect.fromCenter(
      center: dashSize.center(Offset(0 * dashWidth, -0.05 * dashHeight)),
      width: dashWidth / 12,
      height: dashHeight / 8);
  canvas.drawOval(rightEyeInnerOval, eyesInnerPaint);

  // Eyes Reflection 1
  final leftEyeReflection1Oval = Rect.fromCenter(
      center: dashSize.center(Offset(-0.11 * dashWidth, -0.03 * dashHeight)),
      width: dashWidth / 50,
      height: dashHeight / 50);
  canvas.drawOval(leftEyeReflection1Oval, eyesReflectionPaint);

  final rightEyeReflection1Oval = Rect.fromCenter(
      center: dashSize.center(Offset(-0.01 * dashWidth, -0.03 * dashHeight)),
      width: dashWidth / 50,
      height: dashHeight / 50);
  canvas.drawOval(rightEyeReflection1Oval, eyesReflectionPaint);

  // Eyes Reflection 2
  final leftEyeReflection2Oval = Rect.fromCenter(
      center: dashSize.center(Offset(-0.09 * dashWidth, -0.07 * dashHeight)),
      width: dashWidth / 80,
      height: dashHeight / 80);
  canvas.drawOval(leftEyeReflection2Oval, eyesReflectionPaint);

  final rightEyeReflection2Oval = Rect.fromCenter(
      center: dashSize.center(Offset(0.01 * dashWidth, -0.07 * dashHeight)),
      width: dashWidth / 80,
      height: dashHeight / 80);
  canvas.drawOval(rightEyeReflection2Oval, eyesReflectionPaint);

  // Nose
  final noseStart = Offset(dashWidth * 0.44, dashHeight * 0.5);
  final nosePath = Path()
    ..moveTo(noseStart.dx, noseStart.dy)
    ..lineTo(noseStart.dx - dashWidth * 0.4, noseStart.dy + dashHeight * 0.03)
    ..lineTo(noseStart.dx, noseStart.dy + 0.07 * dashHeight)
    ..quadraticBezierTo(
      noseStart.dx + dashWidth * 0.05,
      noseStart.dy + dashHeight * 0.03,
      noseStart.dx,
      noseStart.dy,
    );
  canvas.drawPath(nosePath, nosePaint);

  // Right feet
  final rightFeetStart = Offset(dashWidth * 0.62, dashHeight * 0.70);
  final rightFeetVec =
      Offset(dashWidth * (0.02 + (value) * 0.015), dashHeight * 0.13);
  final rightFeetMiddle = Offset(
      rightFeetStart.dx + rightFeetVec.dx, rightFeetStart.dy + rightFeetVec.dy);
  canvas.drawLine(rightFeetStart, rightFeetMiddle, feetPaint);
  canvas.drawLine(
      rightFeetMiddle,
      Offset(rightFeetMiddle.dx + dashWidth * -0.02,
          rightFeetMiddle.dy + dashHeight * 0.06),
      feetPaint);
  canvas.drawLine(
      rightFeetMiddle,
      Offset(rightFeetMiddle.dx + dashWidth * 0,
          rightFeetMiddle.dy + dashHeight * 0.07),
      feetPaint);
  canvas.drawLine(
      rightFeetMiddle,
      Offset(rightFeetMiddle.dx + dashWidth * 0.02,
          rightFeetMiddle.dy + dashHeight * 0.06),
      feetPaint);

  // Hair
  canvas.save();
  final hairClipPath = Path()
    ..moveTo(dashWidth * 0.41, dashHeight * 0.35)
    ..quadraticBezierTo(
        dashWidth * 0.5, dashHeight * 0.2, dashWidth * 0.6, dashHeight * 0.3)
    ..lineTo(dashWidth, 0)
    ..lineTo(0, 0)
    ..close();
  canvas.clipPath(hairClipPath);

  final hair1Oval = Rect.fromCenter(
      center: dashSize.center(Offset(dashWidth * -0.05, dashHeight * -0.22)),
      width: dashWidth / 15,
      height: dashHeight / 15);
  canvas.drawOval(hair1Oval, eyesOuterPaint);

  final hair2Oval = Rect.fromCenter(
      center: dashSize.center(Offset(dashWidth * -0.01, dashHeight * -0.23)),
      width: dashWidth / 13,
      height: dashHeight / 13);
  canvas.drawOval(hair2Oval, eyesOuterPaint);

  final hair3Oval = Rect.fromCenter(
      center: dashSize.center(Offset(dashWidth * 0.02, dashHeight * -0.23)),
      width: dashWidth / 15,
      height: dashHeight / 15);
  canvas.drawOval(hair3Oval, eyesOuterPaint);
  canvas.restore();

  // Wing
  final rightWing1 = Offset(dashWidth * 0.62, dashHeight * 0.52);
  final rightWing2 = Offset(dashWidth * 0.9, dashHeight * (0.6 - 0.1 * value));
  final rightWingC1 = Offset(
    (rightWing1.dx + rightWing2.dx) / 2 + dashWidth * 0.2,
    (rightWing1.dy + rightWing2.dy) / 2 - dashHeight * 0.2,
  );
  final rightWingC2 =
      Offset(rightWingC1.dx, rightWingC1.dy + dashHeight * 0.45);
  final rightWingPath = Path()
    ..moveTo(rightWing1.dx, rightWing1.dy)
    ..quadraticBezierTo(
        rightWingC1.dx, rightWingC1.dy, rightWing2.dx, rightWing2.dy)
    ..quadraticBezierTo(
        rightWingC2.dx, rightWingC2.dy, rightWing1.dx, rightWing1.dy)
    ..close();

  canvas.save();
  final wingClipPath = Path()
    ..moveTo(dashWidth * 0.68, dashHeight * 0.48)
    ..quadraticBezierTo(
        dashWidth * 0.63, dashHeight * 0.53, dashWidth * 0.7, dashHeight * 0.6)
    ..lineTo(dashWidth, dashHeight)
    ..lineTo(dashWidth, 0)
    ..close();
  canvas.clipPath(wingClipPath);
  canvas.drawPath(rightWingPath, eyesOuterPaint);
  canvas.restore();
  return recorder.endRecording();
}
