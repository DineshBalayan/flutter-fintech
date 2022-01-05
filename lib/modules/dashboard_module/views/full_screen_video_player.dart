import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      initialVideoId: widget.videoId, //Add videoID.
      flags: YoutubePlayerFlags(
        hideControls: false, disableDragSeek: true,
        controlsVisibleAtStart: false,
        autoPlay: true,
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
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        margin: EdgeInsets.only(top: 50.sp, bottom: 50.sp),
        width: (Get.width * .95),
        height: ((Get.width * .95) / 16) * 9,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(40.sp),
            child: YoutubePlayer(
              controller: controller,
              onEnded: (YoutubeMetaData metaData) async {
                Get.back(result: true);
              },
              showVideoProgressIndicator: true,
              bottomActions: [
                SizedBox(width: 42.sp),
                CurrentPosition(),
                SizedBox(width: 24.sp),
                ProgressBar(
                  isExpanded: true,
                ),
                RemainingDuration(),
              ],
              progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent),
            )));
  }
}
