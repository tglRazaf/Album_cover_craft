import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'app_base.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MetadataGod.initialize();
  runApp(const AppBase());
}




