import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../demo_screen.dart';
import 'fancy_widgets1.dart';
import 'other_plasma1.dart';
import 'other_plasma2.dart';

class FancyPlasma1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = _createTween();

    return LayoutBuilder(builder: (context, constraints) {
      final ratio = constraints.maxWidth / constraints.maxHeight;

      return PlayAnimation<TimelineValue<_P>>(
          tween: tween,
          duration: tween.duration,
          builder: (context, child, value) {
            final p1Scale = value.get<double>(_P.p1Scale);
            final p2Scale = value.get<double>(_P.p2Scale);

            final p2 = Positioned.fill(
              key: Key('p2'),
              child: Transform.scale(
                  alignment: Alignment.topLeft,
                  scale: value.get(_P.p2Scale),
                  child: AspectRatio(
                    aspectRatio: ratio,
                    child: _buildPlasma2(value),
                  )),
            );

            final stackWidgets = <Widget>[
              if (p1Scale < 1 || p2Scale < 1)
                Positioned.fill(
                  key: Key('p3'),
                  child: Transform.scale(
                      alignment: Alignment.topRight,
                      scale: 0.5,
                      child: AspectRatio(
                        aspectRatio: ratio,
                        child: OtherPlasma1(),
                      )),
                ),
              if (p1Scale < 1 || p2Scale < 1)
                Positioned.fill(
                  key: Key('p4'),
                  child: Transform.scale(
                      alignment: Alignment.bottomLeft,
                      scale: 0.5,
                      child: AspectRatio(
                        aspectRatio: ratio,
                        child: OtherPlasma2(),
                      )),
                ),
              Positioned.fill(
                key: Key('p1'),
                child: Transform.scale(
                    alignment: Alignment.bottomRight,
                    scale: value.get(_P.p1Scale),
                    child: AspectRatio(
                      aspectRatio: ratio,
                      child: _buildPlasma1(value),
                    )),
              ),
            ];

            if (p1Scale < 1.0) {
              if (p2Scale > 0.5) {
                stackWidgets.add(p2);
              } else {
                stackWidgets.insert(0, p2);
              }
            }

            return Stack(
              children: stackWidgets,
            );
          });
    });
  }

  Widget _buildPlasma1(TimelineValue<_P> value) {
    return FancyPlasmaWidget1(color: value.get<Color>(_P.p1Color));
  }

  Widget _buildPlasma2(TimelineValue<_P> value) {
    return FancyPlasmaWidget2(color: value.get<Color>(_P.p2Color));
  }
}

enum _P { p1Scale, p2Scale, p1Color, p2Color }

TimelineTween<_P> _createTween() {
  final tween = TimelineTween<_P>();

  final red = Colors.red.withOpacity(0.4);
  final blue = Colors.blue.withOpacity(0.4);
  final yellow = Colors.yellow.shade800.withOpacity(0.4);
  final green = Colors.green.shade500.withOpacity(0.4);

  // B1 -> B2
  tween
      .addScene(
        duration: 200.milliseconds,
        begin: (0.25 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeIn,
      )
      .animate(_P.p1Color, tween: red.tweenTo(blue));

  // B2 -> B3
  tween
      .addScene(
        duration: 200.milliseconds,
        begin: (0.5 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeIn,
      )
      .animate(_P.p1Color, tween: blue.tweenTo(yellow));

  // B3 -> B4
  tween
      .addScene(
        duration: 200.milliseconds,
        begin: (0.75 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeIn,
      )
      .animate(_P.p1Color, tween: yellow.tweenTo(green));

  // Unit swap
  tween
      .addScene(
        begin: (0.75 * MUSIC_UNIT_MS).round().milliseconds,
        duration: 500.milliseconds,
        curve: Curves.easeInOut,
      )
      .animate(_P.p1Scale, tween: 1.0.tweenTo(0.5));
  tween
      .addScene(
          duration: 500.milliseconds,
          begin: (1.0 * MUSIC_UNIT_MS).round().milliseconds,
          curve: Curves.easeInOut)
      .animate(
        _P.p2Scale,
        tween: 0.5.tweenTo(1.0),
      );

  // B1 -> B2 (no gong)
  tween
      .addScene(
        begin: (1.2 * MUSIC_UNIT_MS).round().milliseconds,
        end: (1.3 * MUSIC_UNIT_MS).round().milliseconds,
      )
      .animate(_P.p2Color, tween: green.tweenTo(red));

  // B2 -> B3
  tween
      .addScene(
        duration: 200.milliseconds,
        begin: (1.5 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeIn,
      )
      .animate(_P.p2Color, tween: red.tweenTo(blue));

  // B3 -> B4
  tween
      .addScene(
        duration: 200.milliseconds,
        begin: (1.75 * MUSIC_UNIT_MS).round().milliseconds,
        curve: Curves.easeIn,
      )
      .animate(_P.p2Color, tween: blue.tweenTo(yellow));

  tween.addScene(
      end: (2 * MUSIC_UNIT_MS).milliseconds, duration: 1.milliseconds);

  return tween;
}
