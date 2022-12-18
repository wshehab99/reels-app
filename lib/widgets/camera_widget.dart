import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:reels_app/screens/post_preview_screen.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterCamera(
      color: Colors.amber,
      onVideoRecorded: (value) {
        final path = value.path;
        print(path.split("/").last);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostPreviewScreen(path: path)));
      },
    );
  }
}
