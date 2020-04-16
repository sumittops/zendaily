import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class AddItem extends StatelessWidget {
  final String label;
  final Function onTap;

  AddItem({
    this.label,
    this.onTap
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeuCard(
        bevel: 1,
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
        decoration: NeumorphicDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey[200]
        ),
        child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text(label)
            ]
        )
    ));
  }
}