import 'package:AsikVeyselMusicApp/Bloc/music_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicCubit extends Cubit<MusicState> {
  MusicCubit() : super(MusicInitial()) {
    playMusic();
  }

  playMusic() {
    emit(MusicPlay());
  }

  pauseMusic() {
    emit(MusicPause());
  }
}
