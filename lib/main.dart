import 'package:AsikVeyselMusicApp/Core/Constants/App/app_constanst.dart';
import 'package:AsikVeyselMusicApp/Core/Theme/lighttheme.dart';
import 'package:flutter/material.dart';

import 'Views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstansts.appName,
      theme: lightTheme,
      home: Home(),
    );
  }
}
