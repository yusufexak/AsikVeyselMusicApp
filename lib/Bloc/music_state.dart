abstract class MusicState {
  const MusicState();
}

class MusicInitial extends MusicState {
  const MusicInitial();
}

class MusicPlay extends MusicState {
  final Duration totalSecond, second;
  const MusicPlay(this.totalSecond, this.second);
}

class MusicPause extends MusicState {
  final Duration totalSecond, second;
  const MusicPause(this.totalSecond, this.second);
}
