import 'dart:html' as html;

import 'audio.dart';

class AudioPlayerImpl implements AudioPlayer {
  AudioPlayerImpl(this.src) : _audioElement = html.AudioElement(src);

  final html.AudioElement _audioElement;
  final String src;

  @override
  Future<void> pause() async {
    _audioElement.pause();
  }

  @override
  Future<void> play() async {
    await _audioElement.play();
  }

  @override
  Duration get position => Duration(milliseconds: (_audioElement.currentTime * 1000).toInt());
}
