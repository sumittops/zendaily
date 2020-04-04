import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zendaily/tabnav/tab_navigation.dart';

Color _color = Color(0xFFf2f2f2); // Colors.grey[200]

void main() => runApp(NeumorphicApp());

class NeumorphicApp extends StatelessWidget {
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
      home: TabNavigation(),
    );
  }
}
