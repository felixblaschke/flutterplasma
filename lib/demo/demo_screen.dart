import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'effects/shatter.dart';
import 'fancy_plasma1/fancy_plasma1.dart';
import 'fancy_plasma2/fancy_plasma2.dart';
import 'intro/intro.dart';
import 'layout/layout_wall.dart';
import 'outro/outro.dart';
import 'sky/sky.dart';
import 'stars/stars.dart';
import 'startpage/start_page.dart';

import 'audio.dart';

class DemoScreen extends StatefulWidget {
  final VoidCallback onComplete;
  final bool showCredits;

  const DemoScreen({required this.onComplete, required this.showCredits});

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer('assets/assets/music.mp3');

  var control = CustomAnimationControl.STOP;

  var widgets = <Widget>[];

  @override
  void initState() {
    widgets = <Widget>[
      Container(),
      Intro(),
      FancyPlasma1(),
      LayoutWall(),
      FancyPlasma2(),
      Sky(),
      Stars(),
      Container(),
      Outro(onComplete: widget.onComplete),
    ];

    super.initState();
  }

  void _start(Function shatterFn) async {
    if (kIsWeb) {
      await _audioPlayer.play();

      while (true) {
        final position = await _audioPlayer.position;
        if (position > 0.seconds) {
          setState(() => control = CustomAnimationControl.PLAY_FROM_START);
          shatterFn();
          break;
        }
        await 1.milliseconds.delay;
      }
    } else {
      setState(() => control = CustomAnimationControl.PLAY_FROM_START);
      shatterFn();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tween = _createTween(widget.showCredits);

    return Scaffold(
      body: CustomAnimation<TimelineValue<_P>>(
        control: control,
        tween: tween,
        duration: tween.duration,
        builder: (context, child, value) {
          var widgetIndex = value.get<int>(_P.widgetIndex);
          return Container(
            color: Colors.black,
            child: Stack(
              children: [
                Positioned.fill(
                  child: widgets[widgetIndex],
                ),
                if (widgetIndex <= 1)
                  Positioned.fill(
                    child: ShatterScene(
                      builder: (context, shatterFn) =>
                          StartPage(pressedStart: () => _start(shatterFn)),
                    ),
                  ),
              ],
            ),
          );
        },
        animationStatusListener: (status) {
          if (status == AnimationStatus.completed) {
            _audioPlayer.pause();
          }
        },
      ),
    );
  }
}

enum _P { widgetIndex }

TimelineTween<_P> _createTween(bool withCredits) {
  final tween = TimelineTween<_P>();

  final intro = tween
      .addScene(begin: 0.milliseconds, duration: 605.milliseconds)
      .animate(_P.widgetIndex, tween: ConstantTween<int>(0));

  final message = intro
      .addSubsequentScene(duration: MUSIC_UNIT_MS.milliseconds)
      .animate(_P.widgetIndex, tween: ConstantTween<int>(1));

  final plasmas = tween
      .addScene(
          begin: 13068.milliseconds,
          duration: (2 * MUSIC_UNIT_MS).round().milliseconds)
      .animate(_P.widgetIndex, tween: ConstantTween<int>(2));

  final layoutWall = tween
      .addScene(
          begin: 25414.milliseconds,
          duration: (2 * MUSIC_UNIT_MS).round().milliseconds)
      .animate(_P.widgetIndex, tween: ConstantTween<int>(3));

  final plasmaComposition = tween
      .addScene(
          begin: 37728.milliseconds,
          duration: (2 * MUSIC_UNIT_MS).round().milliseconds)
      .animate(_P.widgetIndex, tween: ConstantTween<int>(4));

  final sky = plasmaComposition
      .addSubsequentScene(duration: MUSIC_UNIT_MS.milliseconds)
      .animate(_P.widgetIndex, tween: ConstantTween<int>(5));

  final space = sky
      .addSubsequentScene(duration: MUSIC_UNIT_MS.milliseconds)
      .animate(_P.widgetIndex, tween: ConstantTween<int>(6));

  final dark = space
      .addSubsequentScene(duration: 2000.milliseconds)
      .animate(_P.widgetIndex, tween: ConstantTween<int>(7));

  if (withCredits) {
    var outro = tween
        .addScene(begin: 66275.milliseconds, end: 91532.milliseconds)
        .animate(_P.widgetIndex, tween: ConstantTween<int>(8));

    var end = tween.addScene(begin: 94.seconds, duration: 1.milliseconds);
  }

  return tween;
}

const MUSIC_UNIT_MS = 6165;
