import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reels_app/helper/firebase_firestore_helper.dart';
import 'package:reels_app/helper/location_helper.dart';
import 'package:reels_app/models/user_model.dart';
import 'package:reels_app/models/video_model.dart';
import 'package:reels_app/presentation/resources/size_manger.dart';
import 'package:reels_app/presentation/resources/string_manger.dart';
import 'package:video_player/video_player.dart';
import '../resources/color_manger.dart';

class PostPreviewScreen extends StatefulWidget {
  const PostPreviewScreen({
    super.key,
    required this.path,
  });
  final String path;
  @override
  State<PostPreviewScreen> createState() => _PostPreviewScreenState();
}

class _PostPreviewScreenState extends State<PostPreviewScreen> {
  VideoPlayerController? controller;
  TextEditingController locationController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    LocationHelper.getAddress().then((value) {
      locationController.text = value;
      setState(() {});
    });
    controller = VideoPlayerController.file(
      File(widget.path),
    )..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManger.editPost),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text(StringManger.post),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            await FirebaseFireStoreHelper.uploadVideo(widget.path)
                .then((value) {
              FirebaseFireStoreHelper.postVideo(
                  video: VideoModel(
                videoUrl: value,
                category: categoryController.text,
                title: titleController.text,
                location: locationController.text,
                date: DateTime.now().toString(),
                user: UserModel.currentUser,
              )).then((value) {
                Navigator.pop(context);
              });
            });
          }
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesManger.s10),
          child: Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return StringManger.titleError;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: StringManger.title,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(SizesManger.s15))),
              ),
              const SizedBox(
                height: SizesManger.s10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return StringManger.locationError;
                        }
                        return null;
                      },
                      controller: locationController,
                      decoration: InputDecoration(
                          hintText: StringManger.location,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(SizesManger.s15))),
                    ),
                  ),
                  const SizedBox(
                    width: SizesManger.s15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: categoryController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return StringManger.categoryError;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: StringManger.category,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(SizesManger.s15))),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: SizesManger.s15,
              ),
              InkWell(
                onTap: controller!.value.isPlaying
                    ? () {
                        controller!.pause();
                        setState(() {});
                      }
                    : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: SizesManger.s3_4,
                      child: VideoPlayer(
                        controller!,
                      ),
                    ),
                    IconButton(
                        onPressed: controller!.value.isPlaying
                            ? null
                            : () {
                                controller!.play();
                                setState(() {});
                              },
                        icon: controller!.value.isPlaying
                            ? const SizedBox()
                            : const Icon(
                                Icons.play_circle,
                                color: ColorManger.white70,
                                size: SizesManger.s70,
                              ))
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
