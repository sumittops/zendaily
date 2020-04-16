import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class InputField extends StatelessWidget {
  final Widget child;
  InputField({ @required this.child });
  @override
  Widget build(BuildContext context) {
    return NeuCard(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      color: Colors.white60,
      bevel: 0,
      curveType: CurveType.concave,
      decoration: NeumorphicDecoration(
          borderRadius: BorderRadius.circular(50)
      ),
      child: child
    );
  }
}
