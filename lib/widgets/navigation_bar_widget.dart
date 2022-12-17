import 'package:flutter/material.dart';

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
      items: [
        BottomNavigationBarItem(
          activeIcon: Text(
            "Explore",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          icon: Text("Explore"),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          activeIcon: Text(
            "Library",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          icon: Text("Library"),
          label: "Library",
        ),
      ],
    );
  }
}
