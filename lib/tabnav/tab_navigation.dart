import 'package:flutter/material.dart';
import 'package:zendaily/fun.dart';
import 'package:zendaily/home.dart';
import 'package:zendaily/productive.dart';
import 'tab_nav_button.dart';

class TabNavigation extends StatefulWidget {
  final List<Map<String, dynamic>> tabData = [
    {'icon': Icons.ac_unit, 'name': 'Productive', 'index': 0},
    {'icon': Icons.home, 'name': 'Home', 'index': 1},
    {'icon': Icons.ac_unit, 'name': 'Fun', 'index': 2}
  ];

  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation>
    with SingleTickerProviderStateMixin {
  String currentTabName = 'Home';
  int currentTabIdx = 0;
  int prevTabIdx = 0;
  AnimationController _animationController;
  Animation _animation;

  void _setCurrentTab(int idx) {
    if (idx == currentTabIdx) {
      return;
    }

    setState(() {
      _animationController.value = 0;
      prevTabIdx = currentTabIdx;
      currentTabIdx = idx;
      _animationController.forward();
    });
  }

  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 333));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Widget> _buildTabs() {
    return widget.tabData.toList().map((Map<String, dynamic> item) {
      return TabNavButton(
        iconData: item['icon'],
        label: item['name'],
        active: item['index'] == currentTabIdx,
        onSelect: _setCurrentTab,
        position: item['index'],
      );
    }).toList();
  }

  double getOffsetForPageIndex(double width, int index) {
    double prevPosition = (index - prevTabIdx) * width;
    if (currentTabIdx > prevTabIdx) {
      return prevPosition - width * _animation.value;
    } else {
      return prevPosition + width * _animation.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[300],
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: <Widget>[
                  Transform.translate(
                      offset:
                          Offset(getOffsetForPageIndex(screenWidth, 0), 0),
                      child: Productive()),
                  Transform.translate(
                      offset:
                          Offset(getOffsetForPageIndex(screenWidth, 1), 0),
                      child: Home()),
                  Transform.translate(
                      offset:
                          Offset(getOffsetForPageIndex(screenWidth, 2), 0),
                      child: Fun()),
                ],
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 100,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildTabs()),
        ),
      ],
    );
  }
}
