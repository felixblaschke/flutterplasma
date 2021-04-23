import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../demo_screen.dart';
import 'large_text.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final tween = _createTween(constraints);
      return PlayAnimation<TimelineValue<_P>>(
          tween: tween,
          duration: tween.duration,
          builder: (context, child, value) {
            final textFadeOut = value.get<double>(_P.textFadeOut);

            return Opacity(
              opacity: value.get(_P.sceneOpacity),
              child: Stack(
                children: [
                  Positioned.fill(child: _buildBackground(value)),
                  if (textFadeOut < 1)
                    Positioned.fill(
                        child: Opacity(
                      opacity: 1 - textFadeOut,
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildText(constraints, value),
                      ),
                    ))
                ],
              ),
            );
          });
    });
  }

  Container _buildBackground(TimelineValue<_P> value) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff48066e),
            Color(0xff0c0117),
          ],
          stops: [
            0,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 10,
        color: Color(0x0dec2f0a),
        blur: 0.4,
        size: 1,
        speed: value.get(_P.plasmaSpeed),
        offset: 0,
        blendMode: BlendMode.screen,
        variation1: 0,
        variation2: 0,
        variation3: 0,
        rotation: 0,
      ),
    );
  }

  Container _buildText(BoxConstraints constraints, TimelineValue<_P> value) {
    final size = Size(constraints.maxWidth / 2,
        min(constraints.maxHeight / 3, constraints.maxWidth / 3));
    final textSize = size.width * 0.1;

    final t1fade = value.get<double>(_P.t1fade);
    final t2fade = value.get<double>(_P.t2fade);
    final t3fade = value.get<double>(_P.t3fade);

    return Container(
      width: size.width,
      height: size.height,
      child: Transform.rotate(
        angle: -value.get<double>(_P.textRotate),
        child: Stack(
          children: [
            Positioned(
                child: Opacity(
              opacity: t1fade,
              child: Transform.rotate(
                  angle: t1fade * -0.12,
                  child: LargeText('time to', textSize: textSize)),
            )),
            Positioned(
              left: 0,
              right: 0,
              top: size.height / 2.1 - textSize * 0.75,
              child: Center(
                  child: Transform.scale(
                      scale: t2fade,
                      child: LargeText('reimagine',
                          textSize: textSize * 1.5, bold: true))),
            ),
            Positioned(
                right: size.width * 0.05,
                bottom: 0,
                child: Opacity(
                  opacity: t3fade,
                  child: Transform.translate(
                    offset: Offset(size.width * 0.1 * (1 - t3fade), 0),
                    child: Transform.rotate(
                        angle: t3fade * 0.05,
                        child: LargeText('web graphics', textSize: textSize)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

enum _P {
  sceneOpacity,
  textFadeOut,
  plasmaSpeed,
  textRotate,
  t1fade,
  t2fade,
  t3fade,
}

TimelineTween<_P> _createTween(BoxConstraints constraints) {
  final tween = TimelineTween<_P>();

  final fadeIn = tween
      .addScene(begin: 0.milliseconds, end: 800.milliseconds)
      .animate(_P.sceneOpacity, tween: 0.0.tweenTo(1.0));

  final t1 = tween
      .addScene(
        end: 1738.milliseconds,
        duration: 600.milliseconds,
        curve: Curves.easeOutCubic,
      )
      .animate(_P.t1fade, tween: (0.0).tweenTo(1.0));

  final t2 = t1
      .addSubsequentScene(
        delay: 300.milliseconds,
        duration: 600.milliseconds,
        curve: Curves.easeOutCubic,
      )
      .animate(_P.t2fade, tween: (0.0).tweenTo(1.0));

  final t3 = t2
      .addSubsequentScene(
        delay: 300.milliseconds,
        duration: 600.milliseconds,
        curve: Curves.easeOutCubic,
      )
      .animate(_P.t3fade, tween: (0.0).tweenTo(1.0));

  tween
      .addScene(
          begin: (0.75 * MUSIC_UNIT_MS).round().milliseconds,
          end: (1.75 * MUSIC_UNIT_MS).round().milliseconds)
      .animate(
        _P.textRotate,
        tween: 0.0.tweenTo(30 * 2 * pi),
        curve: _CustomExponentialCurve(),
      );

  tween
      .addScene(
          begin: (1.25 * MUSIC_UNIT_MS).round().milliseconds,
          end: (1.75 * MUSIC_UNIT_MS).round().milliseconds,
          curve: Curves.easeIn)
      .animate(_P.textFadeOut, tween: 0.0.tweenTo(1.0));

  tween
      .addScene(
          begin: MUSIC_UNIT_MS.milliseconds,
          duration: 3.seconds,
          curve: Curves.easeIn)
      .animate(_P.plasmaSpeed, tween: 0.0.tweenTo(50.0));

  tween.addScene(
      begin: (2 * MUSIC_UNIT_MS).milliseconds, duration: 1.milliseconds);

  return tween;
}

/// A custom curve that combines [Curves.easeIn] and [Curves.easeInExpo].
/// This is to prevent the animation to "jump" to motion at the very start
/// when the animation takes a long time.
class _CustomExponentialCurve extends Curve {
  const _CustomExponentialCurve();

  @override
  double transformInternal(double t) {
    var scale = 1.0;
    const easeInPortion = 0.6;
    if (t < easeInPortion) {
      scale = Curves.easeInOut.transform(t * (1 / easeInPortion));
    }
    return Curves.easeInExpo.transformInternal(t) * scale;
  }
}
