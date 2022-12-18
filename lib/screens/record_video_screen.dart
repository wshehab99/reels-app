import 'package:flutter/material.dart';
import 'package:reels_app/widgets/camera_widget.dart';

class RecordVideoScreen extends StatelessWidget {
  const RecordVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Record"),
      ),
      body: CameraPage(),
    );
  }
}
