import 'package:album_cover_craft/injection.dart';
import 'package:flutter/material.dart';
import 'app_base.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const AppBase());
}
