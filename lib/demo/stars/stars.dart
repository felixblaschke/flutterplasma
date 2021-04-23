import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../demo_screen.dart';
import 'flashes.dart';
import 'particles.dart';
import 'stars_background.dart';
import 'static_stars.dart';

class Stars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = _createTween();

    return LayoutBuilder(builder: (context, constraints) {
      return LoopAnimation<TimelineValue<_P>>(
          tween: tween,
          duration: tween.duration,
          builder: (context, child, value) {
            return Stack(
              children: [
                Positioned.fill(child: StarsBackground()),
                Positioned.fill(child: StaticStars()),
                Positioned.fill(child: Flashes()),
                Positioned.fill(
                    child: CustomPaint(
                  painter: ParticlesPainter(value: value.get(_P.particles)),
                )),
                Positioned.fill(
                    child: Center(
                  child: Transform.scale(
                    scale: value.get(_P.scale),
                    child: Transform.rotate(
                      angle: value.get(_P.rotate),
                      child: FlutterLogo(size: constraints.maxWidth * 0.3),
                    ),
                  ),
                ))
              ],
            );
          });
    });
  }
}

enum _P { scale, rotate, particles }

TimelineTween<_P> _createTween() {
  final tween = TimelineTween<_P>();

  tween
      .addScene(
        begin: (0.25 * MUSIC_UNIT_MS).round().milliseconds,
        end: (0.75 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeOutQuad,
      )
      .animate(_P.scale, tween: (0.01).tweenTo(1.5))
      .animate(_P.rotate, tween: (-70.6).tweenTo(0.0));

  tween
      .addScene(
        begin: 0.seconds,
        end: (1 * MUSIC_UNIT_MS).round().milliseconds,
      )
      .animate(_P.particles, tween: (0.0).tweenTo(3.0));

  return tween;
}
