import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../caching_builder.dart';
import '../intro/large_text.dart';

class Outro extends StatelessWidget {
  final VoidCallback? onComplete;

  Outro({this.onComplete});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var fontSize = constraints.maxHeight * 0.04;
      var tween = _createTween(constraints);

      return CustomAnimation<TimelineValue<_P>>(
        tween: tween,
        duration: tween.duration,
        builder: (context, child, value) {
          return Stack(
            children: [
              /* // Background effect disabled to improve performance
              Positioned.fill(
                  child: Opacity(
                      opacity: value.get(_P.opacityBackground),
                      child: _Background())),
               */
              Positioned.fill(child: _buildScrollingText(value, fontSize)),
            ],
          );
        },
        animationStatusListener: (status) {
          if (status == AnimationStatus.completed) {
            onComplete!();
          }
        },
      );
    });
  }

  ClipRect _buildScrollingText(TimelineValue<_P> value, double fontSize) {
    return ClipRect(
      child: OverflowBox(
        maxHeight: double.infinity,
        alignment: Alignment.topCenter,
        child: Transform.translate(
          offset: Offset(0, value.get(_P.scroll)),
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildContent(fontSize, value),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContent(double fontSize, TimelineValue<_P> value) {
    return [
      _buildText('created by', 'Felix Blaschke', fontSize),
      Opacity(
        opacity: value.get(_P.opacityOther),
        child: CachingBuilder<double>(
          cacheKey: fontSize,
          builder: (context) {
            return RepaintBoundary(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSpacer(fontSize),
                  _buildText('directed by', 'Felix Blaschke\nMandy Blaschke',
                      fontSize),
                  _buildSpacer(fontSize),
                  _buildText('Artwork by', 'Mandy Blaschke', fontSize),
                  _buildSpacer(fontSize),
                  _buildText('Made with', 'Flutter', fontSize),
                  _buildSpacer(fontSize),
                  _buildText(
                      'animation package used', 'simple_animations', fontSize),
                  _buildSpacer(fontSize),
                  _buildText('Special thanks to', 'The Flutter Team', fontSize),
                  Container(
                    height: fontSize * 0.2,
                  ),
                  LargeText('for creating this awesome technology.',
                      textSize: fontSize * 0.43),
                ],
              ),
            );
          },
        ),
      )
    ];
  }

  Container _buildSpacer(double fontSize) {
    return Container(
      height: 6 * fontSize,
    );
  }

  Widget _buildText(String title, String content, double fontSize) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LargeText(
            title.toUpperCase(),
            textSize: fontSize * 0.5,
            bold: true,
          ),
          Container(height: fontSize * 0.5),
          LargeText(content, textSize: fontSize),
        ],
      );
    });
  }
}

enum _P { scroll, opacityOther, opacityBackground }

TimelineTween<_P> _createTween(BoxConstraints constraints) {
  var tween = TimelineTween<_P>();

  tween
      .addScene(begin: 2.seconds, duration: 700.milliseconds)
      .animate(_P.opacityOther, tween: (0.0).tweenTo(1.0));

  tween
      .addScene(begin: 1.seconds, duration: 300.milliseconds)
      .animate(_P.opacityBackground, tween: (0.0).tweenTo(1.0));

  tween.addScene(begin: 2.seconds, end: 25.seconds).animate(_P.scroll,
      tween:
          (constraints.maxHeight * 0.45).tweenTo(-constraints.maxHeight * 1.6));

  tween
      .addScene(end: 25.seconds, duration: 700.milliseconds)
      .animate(_P.opacityBackground, tween: (1.0).tweenTo(0.0))
      .animate(_P.opacityOther, tween: (1.0).tweenTo(0.0));

  return tween;
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff092452),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 10,
        color: Color(0xd0010101),
        blur: 0.74,
        size: 0.87,
        speed: 4,
        offset: 0,
        blendMode: BlendMode.darken,
        variation1: 0,
        variation2: 0,
        variation3: 0,
        rotation: -3.14,
      ),
    );
  }
}
