import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'colors.dart';

class LayoutA extends StatelessWidget {
  final double start;

  LayoutA({this.start = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, outerConstraints) {
      final gap = 0.025 * outerConstraints.maxWidth;

      return Container(
        padding: EdgeInsets.all(2 * gap),
        decoration: BoxDecoration(
          color: grey1,
          borderRadius: BorderRadius.all(Radius.circular(gap)),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final tween = _createTween(constraints.maxWidth, gap);

          return CustomAnimation<TimelineValue<_P>>(
              control: CustomAnimationControl.LOOP,
              startPosition: start,
              tween: tween,
              duration: tween.duration,
              builder: (context, child, value) {
                return Container(
                  child: Stack(
                    children: [
                      Positioned(
                          left: value.get(_P.left1),
                          top: value.get(_P.top1),
                          width: value.get(_P.width1),
                          height: value.get(_P.height1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: grey2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(gap)),
                            ),
                          )),
                      Positioned(
                          left: value.get(_P.left2),
                          top: value.get(_P.top2),
                          width: value.get(_P.width2),
                          height: value.get(_P.height2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: grey2,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(gap)),
                            ),
                          ))
                    ],
                  ),
                );
              });
        }),
      );
    });
  }
}

enum _P {
  top1,
  left1,
  width1,
  height1,
  top2,
  left2,
  width2,
  height2,
}

TimelineTween<_P> _createTween(double size, double gap) {
  final tween = TimelineTween<_P>(curve: Curves.easeInOut);
  tween
      .addScene(begin: 0.seconds, duration: 1.milliseconds)
      .animate(_P.top1, tween: ConstantTween<double>(0.0))
      .animate(_P.left1, tween: ConstantTween<double>(0.0));

  final step1 = tween
      .addScene(begin: 500.milliseconds, duration: 700.milliseconds)
      .animate(_P.width1, tween: (size * 0.5 - gap).tweenTo(size));

  final step2 = step1
      .addSubsequentScene(delay: -300.milliseconds, duration: 700.milliseconds)
      .animate(_P.left2, tween: (0.5 * size + gap).tweenTo(0.0));

  final step3 = step2
      .addSubsequentScene(delay: 800.milliseconds, duration: 500.milliseconds)
      .animate(_P.height1, tween: (size * 0.5 - gap).tweenTo(size * 0.2 - gap))
      .animate(_P.top2, tween: (0.5 * size + gap).tweenTo(0.2 * size + gap));

  final step4 = step3
      .addSubsequentScene(delay: 300.milliseconds, duration: 700.milliseconds)
      .animate(_P.height2, tween: (0.5 * size - gap).tweenTo(0.8 * size - gap))
      .animate(_P.width2, tween: (0.5 * size - gap).tweenTo(size));

  step4
      .addSubsequentScene(delay: 1000.milliseconds, duration: 700.milliseconds)
      .animate(_P.width1, tween: (size).tweenTo(size * 0.5 - gap))
      .animate(_P.height1, tween: (size * 0.2 - gap).tweenTo(size * 0.5 - gap))
      .animate(_P.top2, tween: (0.2 * size + gap).tweenTo(0.5 * size + gap))
      .animate(_P.left2, tween: (0.0).tweenTo(0.5 * size + gap))
      .animate(_P.height2, tween: (0.8 * size - gap).tweenTo(0.5 * size - gap))
      .animate(_P.width2, tween: (size).tweenTo(0.5 * size - gap));

  return tween;
}
