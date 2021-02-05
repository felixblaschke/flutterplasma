import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class StarsBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment(-0.4, -1.0),
          end: Alignment(0.3, 1.0),
          colors: [
            Color(0xff20317d),
            Color(0xff1a2452),
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
        color: Color(0x18c537cf),
        blur: 0.34,
        size: 0.88,
        speed: 0,
        offset: 3.8,
        blendMode: BlendMode.srcOver,
        variation1: 0,
        variation2: 0.43,
        variation3: 0,
        rotation: 0,
        child: PlasmaRenderer(
          type: PlasmaType.infinity,
          particles: 10,
          color: Color(0x06bababa),
          blur: 0.4,
          size: 1,
          speed: 0,
          offset: 3.84,
          blendMode: BlendMode.srcOver,
          variation1: 0,
          variation2: 0,
          variation3: 0,
          rotation: 1.31,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.95,
                colors: [
                  Color(0x00000000),
                  Color(0x41000000),
                ],
                stops: [
                  0,
                  1,
                ],
              ),
              backgroundBlendMode: BlendMode.srcOver,
            ),
          ),
        ),
      ),
    );
  }
}
