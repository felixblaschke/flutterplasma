import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import 'gesture_detector_with_click_hover.dart';

class PropertySelect extends StatelessWidget {
  final Function(String) onChanged;
  final String value;
  final List<String> options;

  PropertySelect({this.onChanged, this.value, this.options});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          value: value,
          dropdownColor: '#555555'.toColor(),
          items: _buildDropdownEntries(),
          onChanged: onChanged,
        ),
        MyIconButton(
          icon: Icons.navigate_before,
          onPressed: () => _nextOption(-1),
        ),
        MyIconButton(
          icon: Icons.navigate_next,
          onPressed: () => _nextOption(1),
        )
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownEntries() {
    return options.map((option) {
      return DropdownMenuItem(
        value: option,
        child: Text(option),
      );
    }).toList();
  }

  void _nextOption(int delta) {
    var sortedOptions = options;
    var index = sortedOptions.indexWhere((entry) => entry == value) + delta;

    if (index == sortedOptions.length) {
      index = 0;
    }

    if (index == -1) {
      index = sortedOptions.length - 1;
    }

    onChanged(sortedOptions[index]);
  }
}

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  MyIconButton({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetectorWithClickHover(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Icon(icon, size: 24, color: Colors.white),
      ),
    );
  }
}
