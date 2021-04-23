import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'colors.dart';

class LayoutC extends StatelessWidget {
  final double start;

  const LayoutC({this.start = 0.0});

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
          final tween = _createTween(size, gap);

          return CustomAnimation<TimelineValue<_P>>(
              control: CustomAnimationControl.LOOP,
              startPosition: start,
              tween: tween,
              duration: tween.duration,
              builder: (context, child, value) {
                return Stack(
                  children: [
                    Positioned(
                        left: gap * 2 - value.get<double>(_P.push),
                        top: 0.4 * size,
                        width: 0.25 * size,
                        height: 0.25 * size,
                        child: _buildContentWidget(gap)),
                    Positioned(
                        right: gap * 2 - value.get<double>(_P.push),
                        top: 0.4 * size,
                        width: 0.25 * size,
                        height: 0.25 * size,
                        child: _buildContentWidget(gap)),
                    Positioned.fill(
                        child: Padding(
                      padding: EdgeInsets.all(2 * gap),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeadline(size, gap),
                          _buildTextLine(gap),
                          _buildTextLine(gap),
                          _buildTextLine(gap),
                          Container(height: 3 * gap),
                          _buildHeadline(size, gap),
                          Container(height: 0.25 * size + 4 * gap),
                          _buildHeadline(size, gap),
                          _buildTextLine(gap),
                          _buildTextLine(gap),
                          _buildTextLine(gap),
                        ],
                      ),
                    )),
                    Positioned(
                      left: value.get(_P.left1),
                      top: value.get(_P.top1),
                      width: value.get(_P.width1),
                      height: value.get(_P.height1),
                      child: _buildAnimatedContentWidget(gap, value),
                    ),
                  ],
                );
              });
        }),
      );
    });
  }

  Container _buildContentWidget(double gap) {
    return Container(
        decoration: BoxDecoration(
          color: grey2,
          borderRadius: BorderRadius.all(Radius.circular(gap)),
        ),
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(gap),
        child: Container(
          width: 2 * gap,
          height: 2 * gap,
          decoration: BoxDecoration(
            color: grey4,
            borderRadius: BorderRadius.all(Radius.circular(gap)),
          ),
        ));
  }

  Widget _buildAnimatedContentWidget(double gap, TimelineValue<_P> value) {
    return Container(
        decoration: BoxDecoration(
          color: value.get(_P.color1),
          borderRadius: BorderRadius.all(Radius.circular(gap)),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final size = constraints.maxWidth;
          final gap2 = 0.025 * size;
          return Stack(
            children: [
              if (value.get<double>(_P.opacity2) > 0)
                Positioned.fill(
                  child: Opacity(
                    opacity: value.get(_P.opacity2),
                    child: ClipRect(
                      child: OverflowBox(
                        minHeight: constraints.maxHeight,
                        maxHeight: double.infinity,
                        alignment: Alignment.topCenter,
                        child: Transform.translate(
                          offset: Offset(0, -value.get<double>(_P.scroll2)),
                          child: Padding(
                            padding: EdgeInsets.all(2 * gap),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(height: 0.3 * size),
                                _buildHeadline(size, gap2),
                                Container(height: 2 * gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2, width: 0.6),
                                Container(height: 3 * gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2, width: 0.8),
                                Container(height: 3 * gap2),
                                _buildHeadline(
                                  size,
                                  gap2,
                                ),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2),
                                _buildTextLine(gap2, width: 0.5),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: value.get(_P.top2),
                left: value.get(_P.left2),
                width: value.get(_P.width2),
                height: value.get(_P.height2),
                child: Container(
                  decoration: BoxDecoration(
                    color: value.get(_P.color2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(gap),
                      topRight: Radius.circular(gap),
                      bottomLeft: Radius.circular(value.get(_P.bottomRadius2)),
                      bottomRight: Radius.circular(value.get(_P.bottomRadius2)),
                    ),
                  ),
                ),
              )
            ],
          );
        }));
  }

  Container _buildHeadline(double size, double gap) {
    return Container(
      width: size * 0.5,
      height: 2 * gap,
      margin: EdgeInsets.only(bottom: gap),
      decoration: BoxDecoration(
        color: grey3,
        borderRadius: BorderRadius.all(Radius.circular(0.5 * gap)),
      ),
    );
  }

  Widget _buildTextLine(double gap, {double width = 1.0}) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth * width,
        height: gap,
        margin: EdgeInsets.only(bottom: 0.5 * gap),
        decoration: BoxDecoration(
          color: grey2,
          borderRadius: BorderRadius.all(Radius.circular(0.25 * gap)),
        ),
      );
    });
  }
}

enum _P {
  top1,
  left1,
  width1,
  height1,
  color1,
  top2,
  left2,
  width2,
  height2,
  color2,
  bottomRadius2,
  opacity2,
  scroll2,
  push,
}

TimelineTween<_P> _createTween(double size, double gap) {
  final tween = TimelineTween<_P>(curve: Curves.easeInOut);

  final clickIn = tween
      .addScene(begin: 500.milliseconds, duration: 100.milliseconds)
      .animate(_P.color1, tween: (grey2).tweenTo(grey3));

  final clickOut = clickIn
      .addSubsequentScene(duration: 100.milliseconds)
      .animate(_P.color1, tween: (grey3).tweenTo(grey2));

  final growSide = clickOut
      .addSubsequentScene(delay: 100.milliseconds, duration: 700.milliseconds)
      .animate(_P.left1, tween: ((size - 0.25 * size) / 2).tweenTo(0.0))
      .animate(_P.width1, tween: (0.25 * size).tweenTo(size))
      .animate(_P.top1,
          tween: (0.4 * size).tweenTo(0.0), shiftBegin: 300.milliseconds)
      .animate(_P.height1,
          tween: (0.25 * size).tweenTo(size), shiftBegin: 300.milliseconds)
      .animate(_P.color1,
          tween: (grey2).tweenTo(grey1), shiftBegin: 500.milliseconds);

  growSide
      .addSubsequentScene(delay: -480.milliseconds, duration: 300.milliseconds)
      .animate(_P.push, tween: (0.0).tweenTo(size), curve: Curves.easeIn);

  final openPage = clickOut
      .addSubsequentScene(delay: 100.milliseconds, duration: 700.milliseconds)
      .animate(_P.left2, tween: (gap).tweenTo(0.0))
      .animate(_P.top2, tween: (gap).tweenTo(0.0))
      .animate(_P.width2, tween: (2 * gap).tweenTo(size))
      .animate(_P.height2, tween: (2 * gap).tweenTo(size * 0.3))
      .animate(_P.bottomRadius2, tween: (gap).tweenTo(0.0))
      .animate(_P.opacity2,
          tween: (0.0).tweenTo(1.0),
          shiftBegin: 300.milliseconds,
          shiftEnd: 200.milliseconds)
      .animate(_P.color2, tween: (grey4).tweenTo(grey3));

  final scroll = openPage
      .addSubsequentScene(delay: 500.milliseconds, duration: 900.milliseconds)
      .animate(_P.scroll2,
          tween: (0.0)
              .tweenTo(300.0)
              .curved(Curves.easeOut)
              .curved(Curves.easeOut)
              .curved(Curves.easeOut));

  openPage
      .addSubsequentScene(duration: 1.milliseconds)
      .animate(_P.push, tween: (size).tweenTo(0.0));

  scroll
      .addSubsequentScene(delay: 500.milliseconds, duration: 700.milliseconds)
      .animate(_P.left1, tween: (0.0).tweenTo((size - 0.25 * size) / 2))
      .animate(_P.top1, tween: (0.0).tweenTo(0.4 * size))
      .animate(_P.width1, tween: (size).tweenTo(0.25 * size))
      .animate(_P.height1, tween: (size).tweenTo(0.25 * size))
      .animate(_P.left2, tween: (0.0).tweenTo(gap))
      .animate(_P.top2, tween: (0.0).tweenTo(gap))
      .animate(_P.width2, tween: (size).tweenTo(2 * gap))
      .animate(_P.height2, tween: (size * 0.3).tweenTo(2 * gap))
      .animate(_P.bottomRadius2, tween: (0.0).tweenTo(gap))
      .animate(_P.color1, tween: (grey1).tweenTo(grey2))
      .animate(_P.color2, tween: (grey3).tweenTo(grey4))
      .animate(_P.opacity2,
          tween: (1.0).tweenTo(0.0), shiftEnd: -300.milliseconds)
      .animate(_P.scroll2, tween: (300.0).tweenTo(0.0));

  tween.addScene(begin: 5.seconds, duration: 1.milliseconds);

  return tween;
}
