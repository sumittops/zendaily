import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class TabNavButton extends StatelessWidget {
  final bool active;
  final IconData iconData;
  final String label;
  final int position;
  final Function onSelect;

  TabNavButton({
    this.active,
    this.label,
    this.iconData,
    this.onSelect,
    this.position
  });

  @override
  Widget build(BuildContext context) {
    return NeuButton(
      onPressed: () {
        onSelect(position);
      },
      shape: BoxShape.circle,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
        iconData,
        size: 28,
        color: active ? Colors.cyan : Colors.black38
          ),
      ),
    );
  }
}
