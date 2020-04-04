import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';


class Fun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey[300],
      child: Stack(
        children: <Widget>[
          NeuCard(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 32,
              horizontal: 14
            ),
            child: Text('Fun Zone', style: Theme.of(context).textTheme.headline4),
          )
        ],
      ),
    );
  }
}
