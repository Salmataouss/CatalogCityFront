import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late Future<void> _initializeVideoPlayerFuture;
  VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('');

  VideoPlayerController get videoPlayerController => _videoPlayerController;
  Future<void> get initializeVideoPlayerFuture => _initializeVideoPlayerFuture;

  void initVideoController(String videoPath) {
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoPath));

      _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    } catch (e) {
      debugPrint('🙉 Error: $e');
    }
  }

  void togglePlayButton() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    update();
  }

  void stopVideo() {
    if (isPlaying()) {
      togglePlayButton();
    }
  }

  void toggleVolume() {
    if (_videoPlayerController.value.volume == 0.0) {
      _videoPlayerController.setVolume(1.0);
    } else {
      _videoPlayerController.setVolume(0.0);
    }
    update();
  }

  bool isPlaying() {
    return _videoPlayerController.value.isPlaying;
  }

  bool isMute() {
    return _videoPlayerController.value.volume == 0.0;
  }
}
