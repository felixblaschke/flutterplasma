import 'audio.dart';

// TODO: mobile version not implemented
class AudioPlayerImpl implements AudioPlayer {
  AudioPlayerImpl(this.src);

  final String src;

  @override
  Future<void> pause() async {
  }

  @override
  Future<void> play() async {
  }

  @override
  Duration get position => Duration.zero;
}
