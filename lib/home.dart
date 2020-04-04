import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey[300],
      child: Stack(
        children: <Widget>[
          NeuCard(
            bevel: 1,
            padding: EdgeInsets.all(16),
            decoration:NeumorphicDecoration(
              borderRadius: BorderRadius.circular(6)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Do something', style: Theme.of(context).textTheme.headline2),
                NeuButton(
                  onPressed: () {
                    print('Productive');
                  },

                  child: Text('Productive', style: Theme.of(context).textTheme.button),
                ),
                Text('Or', style: Theme.of(context).textTheme.headline4,),
                NeuButton(
                  onPressed: () {
                    print('Fun');
                  },
                  child: Text('Fun', style: Theme.of(context).textTheme.button),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
