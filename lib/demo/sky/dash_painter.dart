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
ui.Picture paintDash(double value) {
  assert(0.0 <= value && value <= 1.0);
  return _frames[(value * _framesPerAnimationCycle).toInt()];
}

const int _framesPerAnimationCycle = 10;

final List<ui.Picture> _frames = () {
  final frames = <ui.Picture>[];
  for (var i = 0; i < _framesPerAnimationCycle; i++) {
    frames.add(_paintOneFrame(i / _framesPerAnimationCycle));
  }
  return frames;
}();

ui.Picture _paintOneFrame(double value) {
  const width = 1.0;
  const height = 1.0;
  const size = Size(width, height);
  const cullRect = Rect.fromLTRB(0, 0, width, height);

  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder, cullRect);
  var feetPaint = Paint()
    ..strokeWidth = size.width * 0.01
    ..strokeCap = StrokeCap.round
    ..color = '#725D48'.toColor();

  // Left feet
  var leftFeetStart = Offset(size.width * 0.53, size.height * 0.75);
  var leftFeetVec =
      Offset(size.width * (0.01 + value * 0.02), size.height * 0.08);
  var leftFeetMiddle = Offset(
      leftFeetStart.dx + leftFeetVec.dx, leftFeetStart.dy + leftFeetVec.dy);
  canvas.drawLine(leftFeetStart, leftFeetMiddle, feetPaint);
  canvas.drawLine(
      leftFeetMiddle,
      Offset(leftFeetMiddle.dx + size.width * -0.02,
          leftFeetMiddle.dy + size.height * 0.05),
      feetPaint);
  canvas.drawLine(
      leftFeetMiddle,
      Offset(leftFeetMiddle.dx + size.width * 0,
          leftFeetMiddle.dy + size.height * 0.06),
      feetPaint);
  canvas.drawLine(
      leftFeetMiddle,
      Offset(leftFeetMiddle.dx + size.width * 0.02,
          leftFeetMiddle.dy + size.height * 0.05),
      feetPaint);

  // Tail
  var tailPath = Path()
    ..moveTo(size.width * 0.55, size.height * 0.6)
    ..lineTo(size.width * 0.75, size.height * 0.55)
    ..quadraticBezierTo(size.width * 0.95, size.height * 0.55, size.width * 0.9,
        size.height * 0.6)
    ..quadraticBezierTo(size.width * 0.95, size.height * 0.65, size.width * 0.9,
        size.height * 0.68)
    ..quadraticBezierTo(size.width * 0.95, size.height * 0.75, size.width * 0.9,
        size.height * 0.75)
    ..close();
  canvas.drawPath(tailPath, tailPaint);

  // Body
  var bodyOval = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: size.width / (2.2 - 0.03 * value),
      height: size.height / (2 - 0.03 * value));
  canvas.drawOval(bodyOval, bodyPaint);

  // Breast
  canvas.save();
  canvas.clipPath(Path()..addOval(bodyOval));

  var breastOval = Rect.fromCenter(
      center: size.center(Offset(-0.07 * size.width, 0.15 * size.height)),
      width: size.width / 3,
      height: size.height / 3);
  canvas.drawOval(breastOval, breastPaint);
  canvas.restore();

  // Breast color
  canvas.drawOval(
      Rect.fromCenter(
          center: size.center(Offset(
            size.width * -0.05,
            size.height * -0.07,
          )),
          width: size.width / 3.8,
          height: size.height / 3),
      bodyPaint);

  // Eyes Outer
  var leftEyeOval = Rect.fromCenter(
      center: size.center(Offset(-0.1 * size.width, -0.05 * size.height)),
      width: size.width / 6,
      height: size.height / 5);
  canvas.drawOval(leftEyeOval, eyesOuterPaint);

  var rightEyeOval = Rect.fromCenter(
      center: size.center(Offset(0 * size.width, -0.05 * size.height)),
      width: size.width / 6,
      height: size.height / 5);
  canvas.drawOval(rightEyeOval, eyesOuterPaint);

  // Eyes Inner
  var leftEyeInnerOval = Rect.fromCenter(
      center: size.center(Offset(-0.1 * size.width, -0.05 * size.height)),
      width: size.width / 12,
      height: size.height / 8);
  canvas.drawOval(leftEyeInnerOval, eyesInnerPaint);

  var rightEyeInnerOval = Rect.fromCenter(
      center: size.center(Offset(0 * size.width, -0.05 * size.height)),
      width: size.width / 12,
      height: size.height / 8);
  canvas.drawOval(rightEyeInnerOval, eyesInnerPaint);

  // Eyes Reflection 1
  var leftEyeReflection1Oval = Rect.fromCenter(
      center: size.center(Offset(-0.11 * size.width, -0.03 * size.height)),
      width: size.width / 50,
      height: size.height / 50);
  canvas.drawOval(leftEyeReflection1Oval, eyesReflectionPaint);

  var rightEyeReflection1Oval = Rect.fromCenter(
      center: size.center(Offset(-0.01 * size.width, -0.03 * size.height)),
      width: size.width / 50,
      height: size.height / 50);
  canvas.drawOval(rightEyeReflection1Oval, eyesReflectionPaint);

  // Eyes Reflection 2
  var leftEyeReflection2Oval = Rect.fromCenter(
      center: size.center(Offset(-0.09 * size.width, -0.07 * size.height)),
      width: size.width / 80,
      height: size.height / 80);
  canvas.drawOval(leftEyeReflection2Oval, eyesReflectionPaint);

  var rightEyeReflection2Oval = Rect.fromCenter(
      center: size.center(Offset(0.01 * size.width, -0.07 * size.height)),
      width: size.width / 80,
      height: size.height / 80);
  canvas.drawOval(rightEyeReflection2Oval, eyesReflectionPaint);

  // Nose
  var noseStart = Offset(size.width * 0.44, size.height * 0.5);
  var nosePath = Path()
    ..moveTo(noseStart.dx, noseStart.dy)
    ..lineTo(noseStart.dx - size.width * 0.4, noseStart.dy + size.height * 0.03)
    ..lineTo(noseStart.dx, noseStart.dy + 0.07 * size.height)
    ..quadraticBezierTo(
      noseStart.dx + size.width * 0.05,
      noseStart.dy + size.height * 0.03,
      noseStart.dx,
      noseStart.dy,
    );
  canvas.drawPath(nosePath, nosePaint);

  // Right feet
  var rightFeetStart = Offset(size.width * 0.62, size.height * 0.70);
  var rightFeetVec =
      Offset(size.width * (0.02 + (value) * 0.015), size.height * 0.13);
  var rightFeetMiddle = Offset(
      rightFeetStart.dx + rightFeetVec.dx, rightFeetStart.dy + rightFeetVec.dy);
  canvas.drawLine(rightFeetStart, rightFeetMiddle, feetPaint);
  canvas.drawLine(
      rightFeetMiddle,
      Offset(rightFeetMiddle.dx + size.width * -0.02,
          rightFeetMiddle.dy + size.height * 0.06),
      feetPaint);
  canvas.drawLine(
      rightFeetMiddle,
      Offset(rightFeetMiddle.dx + size.width * 0,
          rightFeetMiddle.dy + size.height * 0.07),
      feetPaint);
  canvas.drawLine(
      rightFeetMiddle,
      Offset(rightFeetMiddle.dx + size.width * 0.02,
          rightFeetMiddle.dy + size.height * 0.06),
      feetPaint);

  // Hair
  canvas.save();
  var hairClipPath = Path()
    ..moveTo(size.width * 0.41, size.height * 0.35)
    ..quadraticBezierTo(size.width * 0.5, size.height * 0.2, size.width * 0.6,
        size.height * 0.3)
    ..lineTo(size.width, 0)
    ..lineTo(0, 0)
    ..close();
  canvas.clipPath(hairClipPath);

  var hair1Oval = Rect.fromCenter(
      center: size.center(Offset(size.width * -0.05, size.height * -0.22)),
      width: size.width / 15,
      height: size.height / 15);
  canvas.drawOval(hair1Oval, eyesOuterPaint);

  var hair2Oval = Rect.fromCenter(
      center: size.center(Offset(size.width * -0.01, size.height * -0.23)),
      width: size.width / 13,
      height: size.height / 13);
  canvas.drawOval(hair2Oval, eyesOuterPaint);

  var hair3Oval = Rect.fromCenter(
      center: size.center(Offset(size.width * 0.02, size.height * -0.23)),
      width: size.width / 15,
      height: size.height / 15);
  canvas.drawOval(hair3Oval, eyesOuterPaint);
  canvas.restore();

  // Wing
  var rightWing1 = Offset(size.width * 0.62, size.height * 0.52);
  var rightWing2 = Offset(size.width * 0.9, size.height * (0.6 - 0.1 * value));
  var rightWingC1 = Offset(
    (rightWing1.dx + rightWing2.dx) / 2 + size.width * 0.2,
    (rightWing1.dy + rightWing2.dy) / 2 - size.height * 0.2,
  );
  var rightWingC2 = Offset(rightWingC1.dx, rightWingC1.dy + size.height * 0.45);
  var rightWingPath = Path()
    ..moveTo(rightWing1.dx, rightWing1.dy)
    ..quadraticBezierTo(
        rightWingC1.dx, rightWingC1.dy, rightWing2.dx, rightWing2.dy)
    ..quadraticBezierTo(
        rightWingC2.dx, rightWingC2.dy, rightWing1.dx, rightWing1.dy)
    ..close();

  canvas.save();
  var wingClipPath = Path()
    ..moveTo(size.width * 0.68, size.height * 0.48)
    ..quadraticBezierTo(size.width * 0.63, size.height * 0.53, size.width * 0.7,
        size.height * 0.6)
    ..lineTo(size.width, size.height)
    ..lineTo(size.width, 0)
    ..close();
  canvas.clipPath(wingClipPath);
  canvas.drawPath(rightWingPath, eyesOuterPaint);
  canvas.restore();
  return recorder.endRecording();
}
