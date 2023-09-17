import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/configs/no_scroll_glow_config.dart';
import 'features/craft_metadata/presentation/pages/track_list_page.dart';
import 'features/craft_metadata/presentation/provider/craft_metadata_provider.dart';

class AppBase extends StatelessWidget {
  const AppBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CraftMetadataProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue, colorScheme: const ColorScheme.dark()),
        home: const TrackListPage(),
        builder: (BuildContext c, Widget? widget) {
          return ScrollConfiguration(
            behavior: const NoGlowScrollBehavior(),
            child: widget!,
          );
        },
      ),
    );
  }
}
