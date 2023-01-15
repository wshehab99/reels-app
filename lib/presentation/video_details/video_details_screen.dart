import 'package:flutter/material.dart';
import 'package:reels_app/models/video_model.dart';
import 'package:reels_app/presentation/resources/color_manger.dart';
import 'package:reels_app/presentation/resources/string_manger.dart';
import 'package:video_player/video_player.dart';

import '../resources/size_manger.dart';

class VideoDetailsScreen extends StatefulWidget {
  const VideoDetailsScreen({
    super.key,
    required this.video,
  });
  final VideoModel? video;
  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.video!.videoUrl!)
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value.isInitialized) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          controller.value.isPlaying
                              ? controller.pause()
                              : controller.play();
                        });
                      },
                      icon: Icon(
                        controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow_outlined,
                        size: SizesManger.s45,
                        color: ColorManger.white,
                      ))
                ],
              ),
              const SizedBox(
                height: SizesManger.s10,
              ),
              Text(
                widget.video!.title!,
                style: const TextStyle(
                  fontSize: SizesManger.s18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Container(
                        width: SizesManger.s40,
                        height: SizesManger.s40,
                        padding: const EdgeInsets.symmetric(
                          vertical: SizesManger.s10,
                          horizontal: SizesManger.s5,
                        ),
                        decoration: BoxDecoration(
                            color: ColorManger.lightGrey,
                            borderRadius:
                                BorderRadius.circular(SizesManger.s15)),
                        child: const Text(
                          StringManger.like,
                          style: TextStyle(
                            color: ColorManger.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                        width: SizesManger.s50,
                        height: SizesManger.s40,
                        padding: const EdgeInsets.symmetric(
                          vertical: SizesManger.s10,
                          horizontal: SizesManger.s5,
                        ),
                        decoration: BoxDecoration(
                            color: ColorManger.lightGrey,
                            borderRadius:
                                BorderRadius.circular(SizesManger.s25)),
                        child: const Text(
                          StringManger.disLike,
                          style: TextStyle(
                            color: ColorManger.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                        width: SizesManger.s50,
                        height: SizesManger.s40,
                        padding: const EdgeInsets.symmetric(
                          vertical: SizesManger.s10,
                          horizontal: SizesManger.s5,
                        ),
                        decoration: BoxDecoration(
                            color: ColorManger.lightGrey,
                            borderRadius:
                                BorderRadius.circular(SizesManger.s20)),
                        child: const Text(
                          StringManger.share,
                          style: TextStyle(
                            color: ColorManger.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: SizesManger.s50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "100 views",
                    style: TextStyle(
                      fontSize: SizesManger.s15,
                    ),
                  ),
                  Text(
                    widget.video!.date!,
                    style: const TextStyle(
                      fontSize: SizesManger.s15,
                    ),
                  ),
                  Text(
                    widget.video!.category!,
                    style: const TextStyle(
                      fontSize: SizesManger.s15,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: SizesManger.s15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.video!.user!.phoneNumber!,
                    style: const TextStyle(
                      fontSize: SizesManger.s20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Show All Videos",
                        style: TextStyle(
                          fontSize: SizesManger.s10,
                        ),
                      ))
                ],
              ),
              //comments
            ],
          ),
        ),
      );
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
