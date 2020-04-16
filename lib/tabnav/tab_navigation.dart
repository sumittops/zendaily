import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/bloc/app/app_bloc.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/pages/discover.dart';
import 'package:zendaily/pages/home.dart';
import 'package:zendaily/pages/tasks_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zendaily/repository/irepository.dart';

import 'tab_nav_button.dart';


class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation>
    with SingleTickerProviderStateMixin {
  AppBloc _bloc;
  String currentTabName = 'Home';
  int currentTabIdx = 0;
  int prevTabIdx = 0;
  AnimationController _animationController;
  Animation _animation;
  final List<Map<String, dynamic>> tabData = [
    { 'initialRoute': '/','icon': Icons.home, 'name': 'Home', 'index': 0,  'key': GlobalKey<NavigatorState>(),
      'widget': Home
    },
    { 'initialRoute': '/productive','icon': Icons.view_list, 'name': 'Dashboard', 'index': 1, 'key': GlobalKey<NavigatorState>(),
      'widget': Discover
    }
  ];

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
    final areaRepository = RepositoryProvider.of<IRepository<Area>>(context);
    final projectRepository =
    RepositoryProvider.of<IRepository<Project>>(context);
    final taskRepository = RepositoryProvider.of<IRepository<Task>>(context);
    _bloc = AppBloc(areaRepository, projectRepository, taskRepository);
    _bloc.add(FetchAllData());
  }

  void dispose() {
    _bloc.close();
    _animationController.dispose();
    super.dispose();
  }

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


  List<Widget> _buildTabs() {
    return tabData.toList().map((Map<String, dynamic> item) {
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
        child: BlocProvider.value(
          value: _bloc,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: tabData.map((tabD) {
                  return Transform.translate(
                    offset: Offset(getOffsetForPageIndex(screenWidth, tabD['index']), 0),
                    child: Navigator(
                      key: tabD['key'],
                      initialRoute: tabD['initialRoute'],
                      onGenerateRoute: (RouteSettings settings) {
                        return MaterialPageRoute(
                          builder: (_) => tabD['index'] == 0 ? Home() : Discover()
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: NeuCard(
        bevel: 6,
        decoration: NeumorphicDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
        ),
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildTabs(),
        ),
      ),
    );
  }
}
