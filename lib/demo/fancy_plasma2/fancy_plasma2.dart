import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../demo_screen.dart';

class FancyPlasma2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = _createTween();

    return LayoutBuilder(builder: (context, constraints) {
      final ratio = constraints.maxWidth / constraints.maxHeight;

      return MirrorAnimation<TimelineValue<_P>>(
          tween: tween,
          duration: tween.duration,
          builder: (context, child, value) {
            return _gradient(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Transform.scale(
                        alignment: Alignment.topLeft,
                        scale: value.get(_P.scale),
                        child: AspectRatio(
                          aspectRatio: ratio,
                          child: PlasmaPart1(),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Transform.scale(
                        alignment: Alignment.topRight,
                        scale: value.get(_P.scale),
                        child: AspectRatio(
                          aspectRatio: ratio,
                          child: PlasmaPart2(),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Transform.scale(
                        alignment: Alignment.bottomLeft,
                        scale: value.get(_P.scale),
                        child: AspectRatio(
                          aspectRatio: ratio,
                          child: PlasmaPart3(),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Transform.scale(
                        alignment: Alignment.bottomRight,
                        scale: value.get(_P.scale),
                        child: AspectRatio(
                          aspectRatio: ratio,
                          child: PlasmaPart4(),
                        ),
                      ),
                    ),
                  ],
                ),
                value: value);
          });
    });
  }

  Widget _gradient({Widget? child, required TimelineValue<_P> value}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            value.get<Color>(_P.gradient1),
            value.get<Color>(_P.gradient2),
          ],
          stops: [
            0,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: child,
    );
  }
}

enum _P { scale, gradient1, gradient2 }

TimelineTween<_P> _createTween() {
  // TODO change colors in 2nd unit on each beat (3 color changes)

  final tween = TimelineTween<_P>();
  tween
      .addScene(
        begin: (0.5 * MUSIC_UNIT_MS).round().milliseconds,
        end: MUSIC_UNIT_MS.milliseconds,
        curve: Curves.easeInOut,
      )
      .animate(_P.scale, tween: (0.5).tweenTo(1.0));

  final purple1 = Color(0xff743496);
  final purple2 = Color(0xff31083b);
  final green1 = Color(0xff1CAB12);
  final green2 = Color(0xff095903);
  final red1 = Color(0xffCC2C08);
  final red2 = Color(0xff761802);
  final pink1 = Color(0xffC41091);
  final pink2 = Color(0xff760252);

  tween
      .addScene(
        begin: (1.25 * MUSIC_UNIT_MS).round().milliseconds,
        duration: 200.milliseconds,
      )
      .animate(_P.gradient1, tween: purple1.tweenTo(green1))
      .animate(_P.gradient2, tween: purple2.tweenTo(green2));

  tween
      .addScene(
        begin: (1.5 * MUSIC_UNIT_MS).round().milliseconds,
        duration: 200.milliseconds,
      )
      .animate(_P.gradient1, tween: green1.tweenTo(red1))
      .animate(_P.gradient2, tween: green2.tweenTo(red2));

  tween
      .addScene(
        begin: (1.75 * MUSIC_UNIT_MS).round().milliseconds,
        duration: 200.milliseconds,
      )
      .animate(_P.gradient1, tween: red1.tweenTo(pink1))
      .animate(_P.gradient2, tween: red2.tweenTo(pink2));

  tween.addScene(
      end: (2 * MUSIC_UNIT_MS).round().milliseconds, duration: 1.milliseconds);

  return tween;
}

class PlasmaPart1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlasmaRenderer(
      type: PlasmaType.infinity,
      particles: 6,
      color: Color(0x44e45a23),
      blur: 0.4,
      size: 1,
      speed: 7.18,
      offset: 0,
      blendMode: BlendMode.plus,
      variation1: 0,
      variation2: 0,
      variation3: 0,
      rotation: 0,
    );
  }
}

class PlasmaPart2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlasmaRenderer(
      type: PlasmaType.bubbles,
      particles: 23,
      color: Color(0x2963a6e1),
      blur: 0.16,
      size: 0.51,
      speed: 1.35,
      offset: 0,
      blendMode: BlendMode.screen,
      variation1: 0.31,
      variation2: 0.3,
      variation3: 0.13,
      rotation: 1.05,
    );
  }
}

class PlasmaPart3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlasmaRenderer(
      type: PlasmaType.infinity,
      particles: 10,
      color: Color(0x447be423),
      blur: 0.4,
      size: 1,
      speed: 1,
      offset: 0,
      blendMode: BlendMode.plus,
      variation1: 0.72,
      variation2: 0,
      variation3: 0,
      rotation: 0,
    );
  }
}

class PlasmaPart4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlasmaRenderer(
      type: PlasmaType.circle,
      particles: 10,
      color: Color(0x441290d5),
      blur: 0.4,
      size: 1,
      speed: 1,
      offset: 0,
      blendMode: BlendMode.plus,
      variation1: 0,
      variation2: 0,
      variation3: 0,
      rotation: 0,
    );
  }
}
