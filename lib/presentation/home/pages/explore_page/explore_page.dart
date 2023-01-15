import 'package:flutter/material.dart';
import 'package:reels_app/helper/firebase_firestore_helper.dart';
import 'package:reels_app/models/video_model.dart';

import '../../../common/widgets/video_player_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<VideoModel> snapshot = FirebaseFireStoreHelper.videos;
  bool loading = false;
  @override
  void initState() {
    super.initState();

    loading = true;
    FirebaseFireStoreHelper.gitVideos().then((value) {
      snapshot = value;
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return VideoPlayerWidget(
          video: snapshot[index],
        );
      },
      itemCount: snapshot.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
