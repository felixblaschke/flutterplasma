import 'package:flutter/material.dart';

import 'showroom/show_room.dart';

/// Warms up renderer by rendering each widget for a single frame
class WidgetWarmup extends StatefulWidget {
  final Widget child;

  WidgetWarmup({required this.child});

  @override
  _WidgetWarmupState createState() => _WidgetWarmupState();
}

class _WidgetWarmupState extends State<WidgetWarmup> {
  var _widgetsPrecached = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _afterRender(context));
  }

  @override
  Widget build(BuildContext context) {
    if (!_widgetsPrecached) {
      return Stack(
        children: [
          ...WIDGETS.entries
              .map((entry) => entry.value())
              .map((widget) => Positioned.fill(child: widget)),
          Positioned.fill(child: Container(color: Colors.white)),
        ],
      );
    }

    return widget.child;
  }

  void _afterRender(BuildContext context) {
    if (!_widgetsPrecached) {
      setState(() {
        _widgetsPrecached = true;
      });
    }
  }
}
