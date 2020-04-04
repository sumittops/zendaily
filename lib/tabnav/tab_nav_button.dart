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
    return GestureDetector(
      onTap: () {
        onSelect(position);
      },
      child: NeuCard(
        height: 72,
        width: 72,
        bevel: 2,
        decoration: NeumorphicDecoration(
          borderRadius: BorderRadius.all(Radius.circular(36))
        ),
        child: Transform.scale(
            scale: active ? 1.5 : 1,
            child: Icon(
            iconData,
            size: 28,
            color: active ? Colors.cyan : Colors.black38
          ),
        ),
      ),
    );
  }
}
