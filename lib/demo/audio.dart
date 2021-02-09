import 'audio_io.dart' if (dart.library.html) 'audio_web.dart' as impl;

abstract class AudioPlayer {
  factory AudioPlayer(String src) => impl.AudioPlayerImpl(src);

  Future<void> play();
  Future<void> pause();
  Duration get position;
}
