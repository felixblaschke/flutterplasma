import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../demo_screen.dart';
import 'layout_a.dart';
import 'layout_b.dart';
import 'layout_c.dart';
import 'layout_d.dart';

class LayoutWall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxHeight);
      final tween = _createTween(size);

      return PlayAnimation<TimelineValue<_P>>(
          tween: tween,
          duration: tween.duration,
          builder: (context, child, value) {
            return ClipRect(
              child: Container(
                color: Colors.white,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(value.get(_P.rotateX))
                    ..rotateY(value.get(_P.rotateY)),
                  child: Transform.scale(
                    scale: value.get(_P.scale),
                    child: Transform.translate(
                      offset: Offset(
                          value.get(_P.translateX), value.get(_P.translateY)),
                      child: OverflowBox(
                        minWidth: constraints.maxWidth * 1.25,
                        maxWidth: constraints.maxWidth * 1.25,
                        minHeight: constraints.maxHeight * 1.25,
                        maxHeight: constraints.maxHeight * 1.25,
                        child: Stack(
                          children: _createGrid(context, size),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }

  List<Widget> _createGrid(BuildContext context, Size size) {
    final random = Random(1);

    final grid = <Widget>[];

    final itemSize =
        size.width > size.height ? size.width / 4 : size.height / 4;

    final itemsX = (size.width / itemSize).ceil();
    final itemsY = (size.height / itemSize).ceil();

    0.until(itemsY).forEach((y) {
      0.until(itemsX).forEach((x) {
        grid.add(Positioned(
          left: x * itemSize,
          top: y * itemSize,
          width: itemSize,
          height: itemSize,
          child: Padding(
            padding: EdgeInsets.all(itemSize * 0.1),
            child: AspectRatio(
              aspectRatio: 1,
              child: _randomLayout(random),
            ),
          ),
        ));
      });
    });

    return grid;
  }
}

enum _P { scale, translateX, translateY, rotateX, rotateY }

TimelineTween<_P> _createTween(Size size) {
  final tween = TimelineTween<_P>();

  final shift1 = size.width / 3 * 0.585;

  tween
      .addScene(begin: 0.milliseconds, duration: MUSIC_UNIT_MS.milliseconds)
      .animate(_P.scale, tween: 1.5.tweenTo(1.25))
      .animate(_P.translateX, tween: (shift1).tweenTo(-shift1))
      .animate(_P.translateY, tween: (0.0).tweenTo(shift1 / 2))
      .animate(_P.rotateX, tween: (-1.4).tweenTo(-0.4))
      .animate(_P.rotateY, tween: (0.0).tweenTo(0.0));

  tween
      .addScene(
          begin: MUSIC_UNIT_MS.milliseconds,
          duration: MUSIC_UNIT_MS.milliseconds)
      .animate(_P.scale, tween: 1.3.tweenTo(0.8), curve: Curves.easeOut)
      .animate(_P.translateX, tween: (-shift1 * 1.2).tweenTo(0))
      .animate(_P.rotateX, tween: (-0.0).tweenTo(-0.8))
      .animate(_P.rotateY, tween: (1.0).tweenTo(0.0));

  tween.addScene(
      end: (2 * MUSIC_UNIT_MS).milliseconds, duration: 1.milliseconds);

  return tween;
}

Widget _randomLayout(Random random) {
  return <Widget Function(Random)>[
    (r) => LayoutA(start: r.nextDouble()),
    (r) => LayoutB(start: r.nextDouble()),
    (r) => LayoutC(start: r.nextDouble()),
    (r) => LayoutD(start: r.nextDouble()),
  ].pickOne(random)(random);
}
