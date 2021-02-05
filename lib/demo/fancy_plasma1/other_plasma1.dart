import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class OtherPlasma1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff7b1d17),
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: PlasmaRenderer(
        type: PlasmaType.infinity,
        particles: 10,
        color: Color(0xd0110101),
        blur: 0.74,
        size: 0.87,
        speed: 10,
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
