import 'package:flutter/material.dart';
import 'package:reels_app/presentation/resources/string_manger.dart';

import '../presentation/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringManger.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
