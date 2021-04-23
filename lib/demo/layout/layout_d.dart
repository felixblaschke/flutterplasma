import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'colors.dart';

class LayoutD extends StatelessWidget {
  final double start;

  LayoutD({this.start = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, outerConstraints) {
      final gap = 0.025 * outerConstraints.maxWidth;

      return Container(
        decoration: BoxDecoration(
          color: grey1,
          borderRadius: BorderRadius.all(Radius.circular(gap)),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final size = constraints.maxWidth;
          final boxSize = (size - 6 * gap) / 3.0;
          final tween = _createTween(size, gap);

          return CustomAnimation<TimelineValue<_P>>(
              control: CustomAnimationControl.LOOP,
              startPosition: start,
              tween: tween,
              duration: tween.duration,
              builder: (context, child, value) {
                final shiftY = value.get<double>(_P.shiftY);

                return Stack(
                  children: [
                    _buildContainer(
                        left: 2 * gap, top: 2 * gap, size: boxSize, gap: gap),
                    _buildContainer(
                        left: 3 * gap + boxSize,
                        top: 2 * gap,
                        size: boxSize,
                        gap: gap),
                    _buildContainer(
                        left: 4 * gap + 2 * boxSize,
                        top: 2 * gap,
                        size: boxSize,
                        gap: gap),
                    _buildContainer(
                        left: 2 * gap,
                        top: 3 * gap + boxSize + shiftY,
                        size: boxSize,
                        gap: gap),
                    _buildContainer(
                        left: 3 * gap + boxSize,
                        top: 3 * gap + boxSize + shiftY,
                        size: boxSize,
                        gap: gap),
                    _buildAnimatedContainer(value: value, gap: gap),
                    _buildContainer(
                        left: 2 * gap,
                        top: 4 * gap + 2 * boxSize + shiftY,
                        size: boxSize,
                        gap: gap),
                    _buildContainer(
                        left: 3 * gap + boxSize,
                        top: 4 * gap + 2 * boxSize + shiftY,
                        size: boxSize,
                        gap: gap),
                    _buildContainer(
                        left: 4 * gap + 2 * boxSize,
                        top: 4 * gap + 2 * boxSize + shiftY,
                        size: boxSize,
                        gap: gap),
                  ],
                );
              });
        }),
      );
    });
  }

  Positioned _buildContainer(
      {required double gap,
      required double size,
      required double left,
      required double top}) {
    return Positioned(
        left: left,
        top: top,
        width: size,
        height: size,
        child: Container(
          decoration: BoxDecoration(
            color: grey2,
            borderRadius: BorderRadius.all(Radius.circular(gap)),
          ),
          child: Center(
            child: Icon(
              Icons.play_arrow,
              size: 3 * gap,
              color: grey4,
            ),
          ),
        ));
  }

  Positioned _buildAnimatedContainer(
      {required double gap, required TimelineValue<_P> value}) {
    final videoOpacity = value.get<double>(_P.videoOpacity);

    return Positioned(
        left: value.get(_P.left1),
        top: value.get(_P.top1),
        width: value.get(_P.width1),
        height: value.get(_P.height1),
        child: Container(
          decoration: BoxDecoration(
            color: value.get(_P.color1),
            borderRadius:
                BorderRadius.all(Radius.circular(value.get(_P.borderRadius1))),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Icon(
                    Icons.play_arrow,
                    size: 3 * gap,
                    color: grey4.withOpacity(value.get(_P.playOpacity)),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: videoOpacity > 0
                      ? AspectRatio(
                          aspectRatio: 16.0 / 9.0,
                          child: Opacity(
                            opacity: videoOpacity,
                            child: PlasmaRenderer(
                              type: PlasmaType.circle,
                              particles: 10,
                              color: grey1,
                              blur: 0,
                              size: 0.17,
                              speed: videoOpacity * 6.44,
                              offset: 0,
                              blendMode: BlendMode.srcOver,
                              variation1: 0.37,
                              variation2: 0.62,
                              variation3: 0,
                              rotation: 0,
                            ),
                          ),
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ));
  }
}

enum _P {
  left1,
  top1,
  width1,
  height1,
  color1,
  borderRadius1,
  shiftY,
  videoOpacity,
  playOpacity,
}

TimelineTween<_P> _createTween(double size, double gap) {
  final boxSize = (size - 6 * gap) / 3.0;

  final tween = TimelineTween<_P>(curve: Curves.easeInOut);

  final clickIn = tween
      .addScene(begin: 500.milliseconds, duration: 100.milliseconds)
      .animate(_P.playOpacity, tween: (1.0).tweenTo(0.0))
      .animate(_P.color1, tween: (grey2).tweenTo(grey3));

  // ignore: unused_local_variable
  final clickOut = clickIn
      .addSubsequentScene(duration: 100.milliseconds)
      .animate(_P.color1, tween: (grey3).tweenTo(grey2));

  final createSpace = clickIn
      .addSubsequentScene(duration: 400.milliseconds)
      .animate(_P.shiftY, tween: (0.0).tweenTo(boxSize * 2))
      .animate(_P.height1, tween: (boxSize).tweenTo(boxSize * 2 - gap));

  final open = createSpace
      .addSubsequentScene(delay: 0.milliseconds, duration: 300.milliseconds)
      .animate(_P.left1, tween: (4 * gap + 2 * boxSize).tweenTo(0.0))
      .animate(_P.top1, tween: ConstantTween<double>(3 * gap + boxSize))
      .animate(_P.width1, tween: (boxSize).tweenTo(size))
      .animate(_P.borderRadius1, tween: (gap).tweenTo(3))
      .animate(_P.color1, tween: (grey2).tweenTo(grey3));

  open
      .addSubsequentScene(duration: 300.milliseconds)
      .animate(_P.videoOpacity, tween: (0.0).tweenTo(1.0));

  // ignore: unused_local_variable
  final close = open
      .addSubsequentScene(delay: 2000.milliseconds, duration: 300.milliseconds)
      .animate(_P.videoOpacity, tween: (1.0).tweenTo(0.0))
      .animate(_P.left1, tween: (0.0).tweenTo(4 * gap + 2 * boxSize))
      .animate(_P.width1, tween: (size).tweenTo(boxSize))
      .animate(_P.height1, tween: (boxSize * 2 - gap).tweenTo(boxSize))
      .animate(_P.color1, tween: (grey3).tweenTo(grey2))
      .animate(_P.borderRadius1, tween: (0.0).tweenTo(gap))
      .animate(_P.playOpacity, tween: (0.0).tweenTo(1.0))
      .animate(_P.shiftY,
          tween: (boxSize * 2).tweenTo(0.0),
          shiftBegin: 0.milliseconds,
          shiftEnd: 300.milliseconds);

  return tween;
}
