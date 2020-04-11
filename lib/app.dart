
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:zendaily/models/models.dart';
import 'package:zendaily/pages/onboard/onboard.dart';
import 'package:zendaily/tabnav/tab_navigation.dart';
import 'package:zendaily/utils.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Color _color = Color(0xFFf2f2f2);

  Future<List<dynamic>> _getBoxFutures() {
    return Future.wait([
      Hive.openBox<Area>(BOX_TYPE_AREA),
      Hive.openBox<Project>(BOX_TYPE_PROJECT),
      Hive.openBox<Task>(BOX_TYPE_TASK),
      Hive.openBox<Resource>(BOX_TYPE_RESOURCE),
      Hive.openBox<TaskExecutionRecord>(BOX_TYPE_TASK_EXECUTION)
    ]);
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

    return MaterialApp(
      title: 'Zendaily',
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
      home: FutureBuilder(
        future: _getBoxFutures(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            }
            Box boxArea = Hive.box<Area>(BOX_TYPE_AREA);
            Box projectArea = Hive.box<Project>(BOX_TYPE_PROJECT);
            Box taskArea  = Hive.box<Task>(BOX_TYPE_TASK);
            if (boxArea.isEmpty || projectArea.isEmpty || taskArea.isEmpty) {
              return Onboard();
            }
          return TabNavigation();
          }
          return Scaffold();
        },
      ),
    );
  }

  void dispose() {
    Hive.close();
    super.dispose();
  }
}
