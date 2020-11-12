import 'package:AsikVeyselMusicApp/Bloc/music_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicCubit extends Cubit<MusicState> {
  AudioPlayer _audioPlayer;
  AudioCache _cache;

  Duration _duration = new Duration();
  Duration _position = new Duration();

  MusicCubit() : super(MusicInitial()) {
    _audioPlayer = AudioPlayer();
    _cache = AudioCache(fixedPlayer: _audioPlayer);
    playMusic();
  }

  playMusic() {
    _cache.play("sound/Asik-Veysel-Benim-Sadik-Yarim-Kara-Topraktir.mp3");
    _audioPlayer.onDurationChanged.listen((event) {
      _duration = event;
    });

    _audioPlayer.onAudioPositionChanged.listen((event) {
      _position = event;
      emit(MusicPlay(_duration, _position));
    });
    emit(MusicPlay(_duration, _position));
  }

  pauseMusic() {
    _audioPlayer.pause();
    emit(MusicPause(_duration, _position));
  }

  void seekToSeconds(int second) {
    Duration newDuration = Duration(seconds: second);
    _audioPlayer.seek(newDuration);
  }
}
