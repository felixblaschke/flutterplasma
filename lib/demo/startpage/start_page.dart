import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../showroom/gesture_detector_with_click_hover.dart';
import '../intro/large_text.dart';

class StartPage extends StatelessWidget {
  final Function() pressedStart;

  const StartPage({required this.pressedStart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildPreload(),
        Positioned.fill(
          child: _Background(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Container(
                  constraints: BoxConstraints.expand(width: 700),
                  child: Center(
                    child: _buildPageContent(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildPageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SelectableText('Flutter Plasma', style: h1()),
        Container(height: 24),
        SelectableText(
            'This demo shows the capabilities of Flutter in the web.',
            style: normal()),
        Container(height: 16),
        _Li(
            child: SelectableText.rich(
          TextSpan(
            children: [
              TextSpan(text: 'This is ', style: normal()),
              TextSpan(text: 'not a video', style: bold()),
              TextSpan(
                  text: '. No prebuilt visual assets are used.',
                  style: normal()),
            ],
          ),
        )),
        Container(height: 16),
        _Li(
          child: SelectableText('Turn on your sound.', style: normal()),
        ),
        Container(height: 16),
        _Li(
          child: SelectableText('Enjoy the show.', style: normal()),
        ),
        Container(height: 32),
        SelectableText.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Seizure warning', style: bold()),
              TextSpan(
                  text:
                      ': Don\'t watch this demo if you suffer from photosensitive epilepsy.',
                  style: normal()),
            ],
          ),
        ),
        Container(height: 32),
        Container(
          alignment: Alignment.center,
          child: GestureDetectorWithClickHover(
            onTap: pressedStart,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Play demo', style: link()),
            ),
          ),
        ),
        Spacer(),
        Container(
          alignment: Alignment.center,
          child: GestureDetectorWithClickHover(
            onTap: viewSourceCode,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('View source code', style: link()),
            ),
          ),
        )
      ],
    );
  }

  TextStyle normal() => TextStyle(fontSize: 16, color: Colors.black);

  TextStyle link() => TextStyle(
      fontSize: 16,
      color: 'blue'.toColor(),
      decoration: TextDecoration.underline);

  TextStyle bold() => normal().copyWith(fontWeight: FontWeight.bold);

  TextStyle h1() =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);

  Positioned _buildPreload() {
    return Positioned.fill(
        child: Opacity(
      opacity: 0.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LargeText(
            'a',
            textSize: 16,
            bold: false,
          ),
          LargeText(
            'b',
            textSize: 16,
            bold: true,
          ),
        ],
      ),
    ));
  }

  void viewSourceCode() async {
    var url = 'https://github.com/felixblaschke/flutterplasma/';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class _Li extends StatelessWidget {
  final Widget child;

  const _Li({required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(3.5))),
            width: 7,
            height: 7,
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: child,
          ),
        )
      ],
    );
  }
}

class _Background extends StatelessWidget {
  final Widget child;

  const _Background({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffeeeeee),
            Color(0xff93b4cf),
          ],
          stops: [
            0,
            1,
          ],
        ),
      ),
      child: child,
    );
  }
}
