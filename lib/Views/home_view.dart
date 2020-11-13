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
          appBar: buildMusicAppBar(context),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildRecord(),
              buildMusicNameText(context),
              SizedBox(
                height: 10,
              ),
              buildMusicSubnameText(context),
              buildMusicSlider(state, context),
              buildIconButtonRow(context, state)
            ],
          ),
        );
      },
    );
  }

  Row buildIconButtonRow(BuildContext context, MusicState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(icon: Icon(Icons.skip_previous), onPressed: () {}),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(width: 1.2, color: context.theme.primaryColor)),
          margin: EdgeInsets.all(12),
          child: IconButton(
              icon: Icon((state is MusicPlay) ? Icons.pause : Icons.play_arrow),
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
    );
  }

  Padding buildMusicSlider(MusicState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text((state is MusicPlay)
              ? state.second.toString().split(".").first
              : (state is MusicPause)
                  ? state.second.toString().split(".").first
                  : ""),
          Expanded(
            child: Slider(
              max: (state is MusicPlay)
                  ? state.totalSecond.inSeconds.toDouble()
                  : (state is MusicPause)
                      ? state.totalSecond.inSeconds.toDouble()
                      : 0,
              value: (state is MusicPlay)
                  ? state.second.inSeconds.toDouble()
                  : (state is MusicPause)
                      ? state.second.inSeconds.toDouble()
                      : 1,
              onChanged: (s) {
                context.bloc<MusicCubit>().seekToSeconds(s.toInt());
              },
              activeColor: context.theme.accentColor,
              inactiveColor: context.theme.primaryColor.withOpacity(.5),
            ),
          ),
          Text((state is MusicPlay)
              ? state.totalSecond.toString().split(".").first
              : (state is MusicPause)
                  ? state.totalSecond.toString().split(".").first
                  : ""),
        ],
      ),
    );
  }

  Text buildMusicSubnameText(BuildContext context) {
    return Text(
      AppConstansts.musicSubname,
      style: context.textTheme.bodyText1,
    );
  }

  Text buildMusicNameText(BuildContext context) {
    return Text(
      AppConstansts.musicName,
      style: context.textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Expanded buildRecord() {
    return Expanded(
      child: Padding(
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
    );
  }

  AppBar buildMusicAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      excludeHeaderSemantics: true,
      leading: Padding(
        padding: EdgeInsets.all(10),
        child: SvgPicture.asset(
          AppConstansts.musicalNoteSvg,
          color: context.theme.accentColor,
        ),
      ),
      title: Text(
        AppConstansts.music,
        style: context.textTheme.headline4
            .copyWith(color: context.theme.accentColor),
      ),
    );
  }
}
