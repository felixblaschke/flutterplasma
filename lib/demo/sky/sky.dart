import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../demo_screen.dart';
import 'dash.dart';

class Sky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tween = _createTween();

    return LayoutBuilder(builder: (context, constraints) {
      return LoopAnimation<TimelineValue<_P>>(
          tween: tween,
          duration: tween.duration,
          builder: (context, child, value) {
            var otherDashes = value.get<double>(_P.otherDashes);

            return Stack(
              children: [
                Positioned.fill(child: SkyGradient()),
                Positioned.fill(child: CloudsPlasma()),
                if (otherDashes > 0) ..._otherDashes(otherDashes, constraints),
                Positioned(
                  left: value.get<double>(_P.left1) * constraints.maxWidth,
                  top: value.get<double>(_P.top1) * constraints.maxHeight,
                  width: value.get<double>(_P.size1) * constraints.maxWidth,
                  height: value.get<double>(_P.size1) * constraints.maxWidth,
                  child: Transform.rotate(
                    angle: value.get(_P.rotate1),
                    child: DashAnimation(),
                  ),
                ),
                Positioned.fill(child: ForegroundCloudsPlasma()),
              ],
            );
          });
    });
  }

  List<Positioned> _otherDashes(double value, BoxConstraints constraints) {
    var random = Random(18);
    var randomAngle = Random(16);

    var dashes = <Positioned>[];

    0.until(20).forEach((n) {
      var left = 0.0 + 1.0 * random.nextDouble() + (1 - value) * 0.3;
      var top = 2.4 * (1 - value) - 1.2 + random.nextDouble();
      var size = 0.14 + 0.08 * random.nextDouble() - value * 0.1;

      dashes.add(Positioned(
        left: left * constraints.maxWidth,
        top: top * constraints.maxHeight,
        width: size * constraints.maxWidth,
        height: size * constraints.maxWidth,
        child: Transform.rotate(
            angle: 0.3 + 0.2 * randomAngle.nextDouble(),
            child: DashAnimation()),
      ));
    });

    return dashes;
  }
}

enum _P { left1, top1, size1, rotate1, otherDashes }

TimelineTween<_P> _createTween() {
  var tween = TimelineTween<_P>();

  tween
      .addScene(
        begin: (0.0 * MUSIC_UNIT_MS).round().milliseconds,
        end: (0.25 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeOut,
      )
      .animate(_P.left1, tween: (1.05).tweenTo(0.2))
      .animate(_P.top1, tween: (0.6).tweenTo(0.3))
      .animate(_P.size1, tween: (0.4).tweenTo(0.3));

  tween
      .addScene(
          begin: (0.25 * MUSIC_UNIT_MS).round().milliseconds,
          end: (0.5 * MUSIC_UNIT_MS).round().milliseconds,
          curve: Curves.easeInOut)
      .animate(_P.left1, tween: (0.2).tweenTo(0.3))
      .animate(_P.top1, tween: (0.3).tweenTo(0.4))
      .animate(_P.size1, tween: (0.3).tweenTo(0.35));

  tween
      .addScene(
          begin: (0.5 * MUSIC_UNIT_MS).round().milliseconds,
          end: (0.75 * MUSIC_UNIT_MS).round().milliseconds,
          curve: Curves.easeInOut)
      .animate(_P.left1, tween: (0.3).tweenTo(0.2))
      .animate(_P.top1, tween: (0.4).tweenTo(0.3))
      .animate(_P.size1, tween: (0.35).tweenTo(0.3));

  tween
      .addScene(
        begin: (0.50 * MUSIC_UNIT_MS).round().milliseconds,
        end: (1.0 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeOut,
      )
      .animate(_P.otherDashes, tween: (0.0).tweenTo(1.0));

  var fallIntoSwarm = tween
      .addScene(
        begin: (0.75 * MUSIC_UNIT_MS).round().milliseconds,
        end: (0.83 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeOut,
      )
      .animate(_P.rotate1,
          tween: (0.1).tweenTo(0.35),
          shiftEnd: -400.milliseconds,
          curve: Curves.easeInOut)
      .animate(_P.left1, tween: (0.2).tweenTo(0.35))
      .animate(_P.top1, tween: (0.3).tweenTo(0.4))
      .animate(_P.size1, tween: (0.3).tweenTo(0.2));

  fallIntoSwarm
      .addSubsequentScene(duration: (0.17 * MUSIC_UNIT_MS).round().milliseconds)
      .animate(_P.top1, tween: (0.4).tweenTo(-0.8))
      .animate(_P.left1, tween: (0.35).tweenTo(0.25));

  tween.addScene(end: (MUSIC_UNIT_MS).milliseconds, duration: 1.milliseconds);

  return tween;
}

class SkyGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff214c8f),
            Color(0xff4999d9),
          ],
          stops: [
            0,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
    );
  }
}

class CloudsPlasma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlasmaRenderer(
      type: PlasmaType.bubbles,
      particles: 39,
      color: Color(0x44ffffff),
      blur: 0.55,
      size: 1.44,
      speed: 3.88,
      offset: 0,
      blendMode: BlendMode.srcOver,
      variation1: 0,
      variation2: 0,
      variation3: 0,
      rotation: 1.63,
    );
  }
}

class ForegroundCloudsPlasma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlasmaRenderer(
      type: PlasmaType.bubbles,
      particles: 10,
      color: Color(0x66ffffff),
      blur: 0.55,
      size: 2.44,
      speed: 3.88,
      offset: 0,
      blendMode: BlendMode.srcOver,
      variation1: 0,
      variation2: 0,
      variation3: 0,
      rotation: 1.63,
    );
  }
}
