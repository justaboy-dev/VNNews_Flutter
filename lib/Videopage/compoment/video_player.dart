import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPlayer extends StatefulWidget {
  final String videoSrc;
  const SingleVideoPlayer({Key? key, required this.videoSrc}) : super(key: key);

  @override
  _SingleVideoPlayerState createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoSrc)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void onTap() {
    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: onTap,
        child: controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller))
            : const Padding(
                padding: EdgeInsets.all(100),
                child: Center(
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballRotate,
                      colors: [
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.black,
                        Colors.amber,
                        Colors.orange,
                        Colors.yellow,
                      ],
                      strokeWidth: 0.4,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.black),
                ),
              ),
      ),
    );
  }
}
