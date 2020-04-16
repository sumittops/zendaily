import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:zendaily/bloc/app/app_bloc.dart';
import 'package:zendaily/pages/project_page.dart';
import 'package:zendaily/shared/add_item.dart';
import 'package:zendaily/shared/area_section.dart';

class Discover extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final AppBloc bloc = BlocProvider.of<AppBloc>(context);
    return SafeArea(
      child: Container(
        color: Colors.white60,
        child: BlocBuilder<AppBloc, AppState>(
          bloc: bloc,
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => ProjectPage(
                              project: project,
                            )
                        )
                      );
                    },
                    child: NeuCard(
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
                    ),
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
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ]),
              )
            ],
          );
        },
    ),
      ));
  }
}
