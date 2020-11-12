import 'package:AsikVeyselMusicApp/Bloc/music_cubit.dart';
import 'package:AsikVeyselMusicApp/Bloc/music_state.dart';
import 'package:AsikVeyselMusicApp/Core/Constants/App/app_constanst.dart';
import 'package:flutter/material.dart';
import 'package:AsikVeyselMusicApp/Core/Extension/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 30))
          ..repeat();
    _animation = Tween<double>(begin: 0, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MusicCubit, MusicState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            excludeHeaderSemantics: true,
            leading: Padding(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset(
                AppConstansts.musicalNoteSvg,
                color: context.theme.accentColor,
              ),
            ),
            title: Text(
              "Asik Veysel",
              style: context.textTheme.headline4
                  .copyWith(color: context.theme.accentColor),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RotationTransition(
                    turns: _animation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(child: Image.asset(AppConstansts.recordImage)),
                        Center(
                          child: ClipOval(
                            child: SizedBox(
                                height: 180,
                                width: 180,
                                child: Image.asset(
                                  AppConstansts.veyselImage,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                          ),
                        )
                      ],
                    )),
              ),
              Text(
                "Aşık Veysel",
                style: context.textTheme.headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Kara Toprak",
                style: context.textTheme.bodyText1,
              ),
              Slider(
                max: 25,
                min: 0,
                value: 20,
                onChanged: (s) {},
                activeColor: context.theme.accentColor,
                inactiveColor: context.theme.primaryColor.withOpacity(.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(icon: Icon(Icons.skip_previous), onPressed: () {}),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1.2, color: context.theme.primaryColor)),
                    margin: EdgeInsets.all(12),
                    child: IconButton(
                        icon: Icon((state is MusicPlay)
                            ? Icons.pause
                            : Icons.play_arrow),
                        onPressed: () {
                          if (state is MusicPlay) {
                            context.bloc<MusicCubit>().pauseMusic();
                            _controller.stop();
                          } else {
                            context.bloc<MusicCubit>().playMusic();
                            _controller.repeat();
                          }
                        }),
                  ),
                  IconButton(icon: Icon(Icons.skip_next), onPressed: () {})
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
