import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FancyPlasmaWidget2 extends StatelessWidget {
  const FancyPlasmaWidget2({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment(0.6, -1.0),
          end: Alignment(-0.3, 1.0),
          colors: [
            color.withOpacity(1.0),
            color.withOpacity(1.0),
          ],
          stops: [
            0,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 20,
        color: color,
        blur: 0.5,
        size: 0.5830834600660535,
        speed: 3.916667302449544,
        offset: 0,
        blendMode: BlendMode.plus,
        variation1: 0,
        variation2: 0,
        variation3: 0,
        rotation: 0,
      ),
    );
  }
}

class FancyPlasmaWidget1 extends StatelessWidget {
  const FancyPlasmaWidget1({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xfff44336),
            Color(0xff2196f3),
          ],
          stops: [
            0,
            1,
          ],
        ),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 10,
        color: color,
        blur: 0.4,
        size: 1,
        speed: 6.35,
        offset: 0,
        blendMode: BlendMode.plus,
        variation1: 0,
        variation2: 0,
        variation3: 0,
        rotation: 0,
      ),
    );
  }
}
