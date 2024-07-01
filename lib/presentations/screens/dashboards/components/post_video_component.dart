import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_video_player/cached_video_player.dart';

class PostVideoComponent extends StatefulWidget {
  final String url;
  final String initials;
  final double? width;
  final double? height;
  final double? radius;
  final String id;
  final Function(bool v, CachedVideoPlayerController? controller) play;
  const PostVideoComponent(
      {super.key,
      required this.url,
      required this.initials,
      this.height,
      this.width,
      this.radius,
      required this.id,
      required this.play});

  @override
  State<PostVideoComponent> createState() => _PostVideoComponentState();
}

class _PostVideoComponentState extends State<PostVideoComponent> {
  late CachedVideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(widget.url,
        videoPlayerOptions: VideoPlayerOptions())
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        widget.play(mounted, _controller);
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return SizedBox(
        width: widget.width ?? w(28),
        height: widget.height ?? w(28),
        child: Stack(
          children: [
            Container(
              width: widget.width ?? w(28),
              height: widget.height ?? w(28),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.primaryColor.withOpacity(0.2)),
              child: const Icon(
                Icons.video_camera_back,
                size: 30,
              ),
            ),
          ],
        ),
      );
    }
    return Center(
      key: ValueKey(widget.id),
      child: _controller!.value.isInitialized
          // ? AspectRatio(
          //     aspectRatio: _controller.value.aspectRatio,
          //     child: VideoPlayer(_controller),
          //   )
          ? Container(
              width: widget.width ?? w(28),
              height: widget.height ?? w(28),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.primaryColor.withOpacity(0.2)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedVideoPlayer(_controller!)),
            )
          : SizedBox(
              width: widget.width ?? w(28),
              height: widget.height ?? w(28),
              child: Stack(
                children: [
                  Container(
                    width: widget.width ?? w(28),
                    height: widget.height ?? w(28),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.primaryColor.withOpacity(0.2)),
                    child: const Icon(
                      Icons.video_camera_back,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
    widget.play(false, null);
  }
}
