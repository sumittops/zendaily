import 'package:flutter/material.dart';

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
      child: AnimatedContainer(
        height: 72,
        width: 72,
        duration: Duration(milliseconds: 333),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: active ? Colors.cyan : Colors.grey[300],
          boxShadow: active ? [
            BoxShadow(
              color: Colors.cyan[800], 
              offset: Offset(3, 3),
              blurRadius: 5
            )
          ] : [
            BoxShadow(
              color: Colors.grey[400], 
              offset: Offset(2, 2),
              blurRadius: 5
            )
          ]
        ),
        child: Transform.scale(
            scale: active ? 1.5 : 1,
            child: Icon(
            iconData,
            size: 28,
            color: active ? Colors.white : Colors.black38
          ),
        ),
      ),
    );
  }
}
