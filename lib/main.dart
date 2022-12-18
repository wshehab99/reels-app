import 'package:flutter/material.dart';
import 'package:reels_app/screens/home_screen.dart';
import 'package:reels_app/screens/login_screen.dart';

import 'helper/firebase_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FireBaseHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reels App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
