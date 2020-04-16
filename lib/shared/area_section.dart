import 'package:flutter/material.dart';
import 'package:zendaily/models/models.dart';

class AreaProjectSection extends StatelessWidget {
  final Area area;
  final Map <String, List<Project>> areaProjectMap;

  AreaProjectSection({
    Key key,
    this.area,
    this.areaProjectMap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String projectCountLabel = areaProjectMap[area.id] != null ?
    '${areaProjectMap[area.id].length} projects' : '0 Projects';
    return Container(
      padding: EdgeInsets.only(left: 12, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(area.name, style: Theme.of(context).textTheme.headline5.copyWith(
              color:  Color(area.color)
          )),
          Text(projectCountLabel)
        ],
      ),
    );
  }
}