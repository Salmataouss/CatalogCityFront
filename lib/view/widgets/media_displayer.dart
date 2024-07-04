import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalog_city_project/controller/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../util/asset_image_paths.dart';
import 'shimmer_widget.dart';

class MediaDisplayer extends StatelessWidget {
  const MediaDisplayer({super.key, required this.mediaPath, required this.tag});
  final String mediaPath;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final VideoController videoController = Get.find<VideoController>(tag: tag);

    String videoExtension = '.mp4';
    bool isVideo = mediaPath.endsWith(videoExtension);

    if (isVideo) {
      return FutureBuilder(
        future: videoController.initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Align(
                  alignment: Alignment.center,
                  child: Text('Error Cant Read Video'));
            } else {
              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  VideoPlayer(videoController.videoPlayerController),
                  GetBuilder<VideoController>(
                    tag: tag,
                    builder: (c) => Row(
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            c.togglePlayButton();
                          },
                          icon: Icon(
                            c.isPlaying() ? Icons.play_arrow : Icons.pause,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            c.toggleVolume();
                          },
                          icon: Icon(
                            c.isMute() ? Icons.volume_off : Icons.volume_up,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          } else {
            return ShimmerWidget.rectangular(
              height: 500,
            );
          }
        },
      );
    } else {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: mediaPath,
        placeholder: (context, url) => Image.asset(
          AssetImagePaths.placeholder,
          fit: BoxFit.scaleDown,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }
  }
}
