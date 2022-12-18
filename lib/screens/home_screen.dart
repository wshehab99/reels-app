import 'package:flutter/material.dart';
import 'package:reels_app/screens/explore_page.dart';
import 'package:reels_app/screens/library_page.dart';
import 'package:reels_app/screens/record_video_screen.dart';

import '../widgets/navigation_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const ExplorePage(),
    const LibraryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
          child: const Text(
            "Notifications",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {},
        )
      ]),
      body: pages[currentIndex],
      bottomNavigationBar: AppNavigationBar(
        currentIndex: currentIndex,
        onChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: IconButton(
        icon: const Icon(
          Icons.add,
          color: Colors.black,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecordVideoScreen(),
            ),
          );
        },
      ),
    );
  }
}
