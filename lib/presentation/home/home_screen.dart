import 'package:flutter/material.dart';
import 'package:reels_app/presentation/resources/color_manger.dart';
import 'package:reels_app/presentation/resources/string_manger.dart';

import '../common/widgets/navigation_bar_widget.dart';
import '../record_video/record_video_screen.dart';
import '../resources/size_manger.dart';
import 'pages/explore_page/explore_page.dart';
import 'pages/library_page/library_page.dart';

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
            StringManger.notifications,
            style: TextStyle(color: ColorManger.black),
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
          size: SizesManger.s40,
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
