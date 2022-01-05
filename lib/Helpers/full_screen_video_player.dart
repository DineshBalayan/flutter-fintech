import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoId;

  const FullScreenVideoPlayer({Key? key, required this.videoId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FullScreenVideoPlayerState();
  }
}

class FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        disableDragSeek: true,
        controlsVisibleAtStart: false,
        mute: false,
      ),
    );
    controller.toggleFullScreenMode();
    super.initState();
  }

  @override
  void dispose() {
    controller.toggleFullScreenMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: YoutubePlayer(
        controller: controller,
        onEnded: (metaData) {
          Get.back(result: true);
        },
        /*bottomActions: [
          SizedBox(width: 14.0),
          CurrentPosition(),
          SizedBox(width: 8.0),
          Center(
            child: IgnorePointer(
              child: ProgressBar(
                isExpanded: true,
              ),
              ignoring: true,
            ),
          ),
          RemainingDuration(),
        ],*/
        progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent),
      ),
    );
  }
}
