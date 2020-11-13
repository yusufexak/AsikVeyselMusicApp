import 'package:AsikVeyselMusicApp/Bloc/music_cubit.dart';
import 'package:AsikVeyselMusicApp/Core/Constants/App/app_constanst.dart';
import 'package:AsikVeyselMusicApp/Core/Theme/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MusicCubit>(
          create: (context) => MusicCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstansts.appName,
        theme: lightTheme,
        home: Home(),
      ),
    );
  }
}
