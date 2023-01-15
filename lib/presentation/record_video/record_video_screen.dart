import 'package:flutter/material.dart';
import 'package:reels_app/presentation/common/widgets/camera_widget.dart';
import 'package:reels_app/presentation/resources/string_manger.dart';

class RecordVideoScreen extends StatelessWidget {
  const RecordVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManger.record),
      ),
      body: const CameraPage(),
    );
  }
}
