import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reels_app/helper/firebase_firestore_helper.dart';
import 'package:reels_app/helper/location_helper.dart';
import 'package:reels_app/models/user_model.dart';
import 'package:reels_app/models/video_model.dart';
import 'package:video_player/video_player.dart';

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
      print(value);
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
        title: const Text("Edit Post"),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text("Post"),
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
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "title must not be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "location must not be empty";
                        }
                        return null;
                      },
                      controller: locationController,
                      decoration: InputDecoration(
                          hintText: 'location',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: categoryController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "title must not be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'category',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                      aspectRatio: 3 / 4,
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
                                color: Colors.white70,
                                size: 70,
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
