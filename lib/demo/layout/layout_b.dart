import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'colors.dart';

class LayoutB extends StatelessWidget {
  final double start;

  const LayoutB({this.start = 0.0});

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
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(gap),
                                topRight: Radius.circular(
                                    value.get(_P.rightBorderRadius1)),
                                bottomLeft: Radius.circular(gap),
                                bottomRight: Radius.circular(
                                    value.get(_P.rightBorderRadius1)),
                              ),
                            ),
                          )),
                      Positioned(
                          left: value.get<double>(_P.left1) +
                              value.get<double>(_P.width1) +
                              2 * gap,
                          right: 2 * gap,
                          height: constraints.maxHeight,
                          child: ClipRect(
                            child: OverflowBox(
                              alignment: Alignment.topCenter,
                              maxHeight: double.infinity,
                              child: Transform.translate(
                                offset: Offset(
                                    0, -value.get<double>(_P.pageScroll)),
                                child: _buildContentColumn(
                                    gap, constraints, value),
                              ),
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

  Container _buildContentColumn(
      double gap, BoxConstraints constraints, TimelineValue<_P> value) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 2 * gap),
          _buildHeadlineContainer(gap, constraints),
          _buildContentContainer(gap),
          _buildContentContainer(gap),
          _buildContentContainer(gap),
          _buildContentContainer(gap),
          Container(height: 6 * gap),
          _buildHeadlineContainer(gap, constraints),
          _buildContentContainer(gap),
          _buildContentContainer(gap),
          Container(height: 6 * gap),
          _buildHeadlineContainer(gap, constraints),
          _buildContentContainer(gap),
          _buildContentContainer(gap),
          _buildContentContainer(gap,
              color: value.get(_P.contentColor),
              heightScale: value.get(_P.contentHeight)),
          _buildContentContainer(gap),
        ],
      ),
    );
  }

  Container _buildHeadlineContainer(double gap, BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.only(bottom: gap),
      width: constraints.maxWidth * 0.25,
      height: 1.5 * gap,
      decoration: BoxDecoration(
          color: grey3,
          borderRadius: BorderRadius.all(Radius.circular(0.5 * gap))),
    );
  }

  Container _buildContentContainer(double gap,
      {Color? color, double heightScale = 1.0}) {
    return Container(
      margin: EdgeInsets.only(bottom: gap),
      constraints: BoxConstraints.expand(height: 3 * gap * heightScale),
      decoration: BoxDecoration(
          color: color ?? grey2,
          borderRadius: BorderRadius.all(Radius.circular(0.5 * gap))),
    );
  }
}

enum _P {
  top1,
  left1,
  width1,
  height1,
  rightBorderRadius1,
  pageScroll,
  contentColor,
  contentHeight,
}

TimelineTween<_P> _createTween(double size, double gap) {
  final tween = TimelineTween<_P>(curve: Curves.easeInOut);

  final scroll1 = tween
      .addScene(begin: 500.milliseconds, duration: 900.milliseconds)
      .animate(_P.pageScroll,
          tween: 0.0
              .tweenTo(320.0)
              .curved(Curves.easeOut)
              .curved(Curves.easeOut)
              .curved(Curves.easeOut));

  final scroll2 = scroll1
      .addSubsequentScene(duration: 600.milliseconds)
      .animate(_P.pageScroll,
          tween: 320.0
              .tweenTo(400.0)
              .curved(Curves.easeOut)
              .curved(Curves.easeOut)
              .curved(Curves.easeOut));

  final clickIn = scroll2
      .addSubsequentScene(delay: 300.milliseconds, duration: 100.milliseconds)
      .animate(_P.contentColor, tween: grey2.tweenTo(grey3));

  final clickOut = clickIn
      .addSubsequentScene(duration: 100.milliseconds)
      .animate(_P.contentColor, tween: grey3.tweenTo(grey2));

  final focus = clickOut
      .addSubsequentScene(delay: 100.milliseconds, duration: 1200.milliseconds)
      .animate(_P.left1, tween: (2 * gap).tweenTo(0.0))
      .animate(_P.top1, tween: (2 * gap).tweenTo(0.0))
      .animate(_P.width1, tween: (size * 0.3).tweenTo(size * 0.35 - gap))
      .animate(_P.height1, tween: (size * 0.3).tweenTo(size))
      .animate(_P.rightBorderRadius1, tween: (gap).tweenTo(0))
      .animate(_P.contentHeight, tween: 1.0.tweenTo(6.0))
      .animate(_P.contentColor, tween: grey2.tweenTo(grey4))
      .animate(_P.pageScroll, tween: 400.0.tweenTo(600.0));

  final fadeBack = focus
      .addSubsequentScene(delay: 1.seconds, duration: 1200.milliseconds)
      .animate(_P.left1, tween: (0.0).tweenTo(2 * gap))
      .animate(_P.top1, tween: (0.0).tweenTo(2 * gap))
      .animate(_P.width1, tween: (size * 0.35 - gap).tweenTo(size * 0.3))
      .animate(_P.height1, tween: (size).tweenTo(size * 0.3))
      .animate(_P.rightBorderRadius1, tween: (0.0).tweenTo(gap))
      .animate(_P.contentHeight, tween: 6.0.tweenTo(1.0))
      .animate(_P.contentColor, tween: grey4.tweenTo(grey2))
      .animate(_P.pageScroll, tween: 600.0.tweenTo(0.0));

  fadeBack.addSubsequentScene(duration: 500.milliseconds);

  return tween;
}
