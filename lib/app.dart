
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/pages/onboard/onboard.dart';
import 'package:zendaily/repository/repository.dart';
import 'package:zendaily/tabnav/tab_navigation.dart';

class App extends StatelessWidget {
  final Box areaBox;
  final Box projectBox;
  final Box taskBox;
  final Box resourceBox;
  final Box taskExecBox;

  App({
    @required this.areaBox,
    @required this.projectBox,
    @required this.taskBox,
    @required this.resourceBox,
    @required this.taskExecBox
  });
  final Color _color = Color(0xFFf2f2f2);


  List<RepositoryProvider> _getRepoProviders() {
    return [
      RepositoryProvider<IRepository<Area>>(
        create: (_)=> AreaRepository(
          source: HiveRepository<Area>(this.areaBox)
        ),
      ),
      RepositoryProvider<IRepository<Project>>(
        create: (_)=> ProjectRepository(
          source: HiveRepository<Project>(this.projectBox)
        ),
      ),
      RepositoryProvider<IRepository<Task>>(
        create: (_)=> TaskRepository(
          source: HiveRepository<Task>(this.taskBox)
        ),
      )
    ];
  }

   @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: _color,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    Widget startWidget = TabNavigation();

    if (areaBox.isEmpty || projectBox.isEmpty || taskBox.isEmpty) {
      startWidget = Onboard();
    }
    return MultiRepositoryProvider(
      providers: _getRepoProviders(),
      child: MaterialApp(
        title: 'PARADay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          primarySwatch: Colors.blue,
          backgroundColor: Color.lerp(_color, Colors.black, 0.005),
          scaffoldBackgroundColor: _color,
          dialogBackgroundColor: Colors.grey[300],
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: _color,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
        ),
        home: Scaffold(
          body: startWidget
        )
      ),
    );
  }
}
