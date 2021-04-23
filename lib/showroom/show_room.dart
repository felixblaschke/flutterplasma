import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../demo/fancy_plasma1/fancy_widgets1.dart';
import '../demo/fancy_plasma1/other_plasma1.dart';
import '../demo/fancy_plasma1/other_plasma2.dart';
import '../demo/fancy_plasma2/fancy_plasma2.dart';
import '../demo/intro/large_text.dart';
import '../demo/layout/layout_a.dart';
import '../demo/layout/layout_b.dart';
import '../demo/layout/layout_c.dart';
import '../demo/layout/layout_d.dart';
import '../demo/layout/layout_wall.dart';
import '../demo/outro/outro.dart';
import '../demo/sky/dash.dart';
import '../demo/sky/sky.dart';
import '../demo/stars/stars.dart';
import '../showroom/select.dart';

class ShowRoom extends StatefulWidget {
  final int index;
  final Function(int) onIndexChange;

  const ShowRoom({required this.index, required this.onIndexChange});

  @override
  _ShowRoomState createState() => _ShowRoomState();
}

class _ShowRoomState extends State<ShowRoom> {
  Widget displayedWidget = _introText();
  String selectedItem = 'Pick a widget here...';

  void changeWidgetFromOutside(int index) {
    setState(() {
      var allWidgets = WIDGETS.entries.toList();
      try {
        selectedItem = allWidgets[widget.index].key;
        displayedWidget = allWidgets[widget.index].value();
      } catch (e) {
        selectedItem = allWidgets[0].key;
        displayedWidget = allWidgets[0].value();
      }
    });
  }

  void changeWidgetInternally(String key) {
    var allWidgets = WIDGETS.entries.toList();
    var index = allWidgets.indexWhere((element) => element.key == key);
    widget.onIndexChange(index);
  }

  @override
  void initState() {
    changeWidgetFromOutside(widget.index);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ShowRoom oldWidget) {
    changeWidgetFromOutside(widget.index);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var smallScreen = constraints.maxWidth < 700;
      var spacing = smallScreen ? 0.0 : 32.0;

      return Container(
        color: '#333333'.toColor(),
        child: Column(
          children: [
            Container(
              height: 50.0,
              padding: EdgeInsets.symmetric(horizontal: spacing),
              color: Colors.black.withOpacity(0.3),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: smallScreen ? 16 : 0),
                    child: LargeText(
                      'ShowRoom',
                      bold: true,
                      textSize: smallScreen ? 14 : 18,
                    ),
                  ),
                  Spacer(),
                  PropertySelect(
                    value: selectedItem,
                    onChanged: (newValue) {
                      changeWidgetInternally(newValue!);
                    },
                    options: WIDGETS.keys.toList(),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(spacing),
                    child: displayedWidget,
                  ),
                ))
          ],
        ),
      );
    });
  }
}

var WIDGETS = {
  'Pick a widget here...': () => _introText(),
  'Layout A': () => _square(LayoutA()),
  'Layout B': () => _square(LayoutB()),
  'Layout C': () => _square(LayoutC()),
  'Layout D': () => _square(LayoutD()),
  'Layout Wall': () => LayoutWall(),
  'Plasma 1 (blue)': () =>
      FancyPlasmaWidget1(color: Colors.blue.withOpacity(0.4)),
  'Plasma 1 (red)': () =>
      FancyPlasmaWidget1(color: Colors.red.withOpacity(0.4)),
  'Plasma 1 (yellow)': () =>
      FancyPlasmaWidget1(color: Colors.yellow.withOpacity(0.4)),
  'Plasma 1 (green)': () =>
      FancyPlasmaWidget1(color: Colors.green.withOpacity(0.4)),
  'Plasma 2 (blue)': () =>
      FancyPlasmaWidget2(color: Colors.blue.withOpacity(0.4)),
  'Plasma 2 (red)': () =>
      FancyPlasmaWidget2(color: Colors.red.withOpacity(0.4)),
  'Plasma 2 (yellow)': () =>
      FancyPlasmaWidget2(color: Colors.yellow.withOpacity(0.4)),
  'Plasma 2 (green)': () =>
      FancyPlasmaWidget2(color: Colors.green.withOpacity(0.4)),
  'Plasma 3': () => OtherPlasma1(),
  'Plasma 4': () => OtherPlasma2(),
  'Plasma 5': () => FancyPlasma2(),
  'Sky': () => Sky(),
  'Dash': () => DashAnimation(),
  'Stars': () => Stars(),
  'Outro': () => Outro(),
};

Widget _square(Widget child) => AspectRatio(
      aspectRatio: 1,
      child: child,
    );

Widget _introText() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: LargeText(
      'Use the select box on the top right to navigate between screens.',
      textSize: 16,
    ),
  );
}

Widget Function() stringToWidgetBuilder(String string) {
  return WIDGETS.entries.firstWhere((w) => w.key == string).value;
}
