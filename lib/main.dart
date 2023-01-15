import 'package:flutter/material.dart';

import 'app/app.dart';
import 'helper/firebase_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FireBaseHelper.init();
  runApp(const MyApp());
}
