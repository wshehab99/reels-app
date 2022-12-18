import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reels_app/helper/firebase_firestore_helper.dart';

import '../widgets/video_player_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  QuerySnapshot<Map<String, dynamic>>? snapshot;
  @override
  void initState() {
    super.initState();
    FirebaseFireStoreHelper.gitVideos().then((value) {
      setState(() {
        snapshot = value;
        print(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VideoPlayerWidget(),
      ],
    );
  }
}
