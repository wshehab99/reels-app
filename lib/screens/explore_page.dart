import 'package:flutter/material.dart';

import '../widgets/video_player_widget.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VideoPlayerWidget(),
      ],
    );
  }
}
