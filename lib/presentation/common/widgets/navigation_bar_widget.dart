import 'package:flutter/material.dart';
import 'package:reels_app/presentation/resources/color_manger.dart';
import 'package:reels_app/presentation/resources/string_manger.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    this.currentIndex,
    this.onChange,
  });
  final int? currentIndex;
  final void Function(int)? onChange;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex!,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: onChange,
      items: const [
        BottomNavigationBarItem(
          activeIcon: Text(
            StringManger.explore,
            style: TextStyle(
              color: ColorManger.blue,
            ),
          ),
          icon: Text(StringManger.explore),
          label: StringManger.explore,
        ),
        BottomNavigationBarItem(
          activeIcon: Text(
            StringManger.library,
            style: TextStyle(
              color: ColorManger.blue,
            ),
          ),
          icon: Text(StringManger.library),
          label: StringManger.library,
        ),
      ],
    );
  }
}
