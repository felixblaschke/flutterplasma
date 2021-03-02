import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:url_strategy/url_strategy.dart';

import 'demo/intro/intro.dart';
import 'routed_app.dart';

import 'demo/sky/dash_painter.dart';

void main() async {
  await initializeDashPainter();
  setPathUrlStrategy();

  if (kReleaseMode || kProfileMode) {
    runApp(RoutedApp());
  } else {
    runApp(RoutedApp());
  }
}

/// Can be used instead of RoutedApp to develop and test
/// a single part of the application.
class DevApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.black,
          child: SafeArea(
            child: AnimationDeveloperTools(
              // position: AnimationDeveloperToolsPosition.hidden,
              child: LayoutBuilder(builder: (context, constraints) {
                return Center(
                    child: AspectRatio(
                  //aspectRatio: 5/10,
                  aspectRatio: constraints.maxWidth / constraints.maxHeight,
                  child: Intro(),
                ));
              }),
            ),
          ),
        ),
      ),
    );
  }
}
