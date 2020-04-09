import 'package:flutter/material.dart';
import 'package:zendaily/pages/home.dart';
import 'package:zendaily/pages/tasks_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'tab_nav_button.dart';


class TabNavigation extends StatefulWidget {
  final List<Map<String, dynamic>> tabData = [
    { 'initialRoute': '/','icon': FontAwesomeIcons.yinYang, 'name': 'Home', 'index': 0,  'key': GlobalKey<NavigatorState>(), 'widget': Home()},
    { 'initialRoute': '/productive','icon': FontAwesomeIcons.tasks, 'name': 'Productive', 'index': 1, 'key': GlobalKey<NavigatorState>(), 'widget': TasksPage(title: 'Productive',)},
    { 'initialRoute': '/chill','icon': FontAwesomeIcons.schlix, 'name': 'Fun', 'index': 2,  'key': GlobalKey<NavigatorState>(), 'widget': TasksPage(title: 'Fun',)}
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
        AnimationController(vsync: this, duration: Duration(milliseconds : 333));
    CurvedAnimation _curvedAnim = CurvedAnimation(
      curve: Curves.easeIn,
      reverseCurve: Curves.bounceOut,
      parent: _animationController
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_curvedAnim)
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
    return prevPosition + (prevTabIdx - currentTabIdx) * width * _animation.value;
    
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              children: widget.tabData.map((tabD) {
                return Transform.translate(
                  offset: Offset(getOffsetForPageIndex(screenWidth, tabD['index']), 0),
                  child: Navigator(
                    key: tabD['key'],
                    initialRoute: tabD['initialRoute'],
                    onGenerateRoute: (RouteSettings settings) {
                      return MaterialPageRoute(
                        builder: (_) => tabD['widget']
                      );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildTabs(),
      ),
    );
  }
}
