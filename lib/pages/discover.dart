import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/bloc/app/app_bloc.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/repository/repository.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  AppBloc _bloc;

  @override
  void initState() {
    final areaRepository = RepositoryProvider.of<IRepository<Area>>(context);
    final projectRepository =
        RepositoryProvider.of<IRepository<Project>>(context);
    final taskRepository = RepositoryProvider.of<IRepository<Task>>(context);
    _bloc = AppBloc(areaRepository, projectRepository, taskRepository);
    _bloc.add(FetchAllData());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocBuilder<AppBloc, AppState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.areaLoading || state.projectLoading || state.taskLoading) {
          return CustomScrollView(
            slivers: [SliverList(
              delegate: SliverChildListDelegate([
                  SizedBox(height: 20,),
                  Center(child: CircularProgressIndicator())
              ]),
            )]
          );
        }
        if (state.areas.isNotEmpty) {
          final areas = state.areas.toList();
          final slivers = areas.map((area) {
            if (state.areaProjectMap[area.id] != null) {
              final projectTiles = state.areaProjectMap[area.id].map((project) {
                return NeuCard(
                  bevel: 1,
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.all(12),
                  decoration: NeumorphicDecoration(
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(project.name, style: Theme.of(context).textTheme.headline6),
                      Text('${state.projectTaskMap[project.id].length} tasks')
                    ]
                  )
                );
              }).toList();
              return SliverList(
                  delegate: SliverChildListDelegate([
                    AreaProjectSection(
                        area: area,
                        areaProjectMap: state.areaProjectMap
                    ),
                    ...projectTiles,
                    AddItem(label: 'Add project', onTap: () {})
                  ])
              );
            }
            return SliverList(delegate: SliverChildListDelegate([
              AreaProjectSection(
                area: area,
                areaProjectMap: state.areaProjectMap
              ),
              AddItem(label: 'Add project', onTap: () {})
            ]));
          }).toList();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: slivers,
            ),
          );
        }
        return CustomScrollView(
          slivers: [],
        );
      },
    ));
  }
}

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

class AddItem extends StatelessWidget {
  final String label;
  final Function onTap;

  AddItem({
    this.label,
    this.onTap
  });

  Widget build(BuildContext context) {
    return GestureDetector(child: NeuCard(
      bevel: 1,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: NeumorphicDecoration(
          borderRadius: BorderRadius.circular(6)
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