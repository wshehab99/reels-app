import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:reels_app/screens/post_preview_screen.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterCamera(
      color: Colors.amber,
      onVideoRecorded: (value) {
        final path = value.path;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPreviewScreen(path: path),
          ),
        );
      },
    );
  }
}
