import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/configs/no_scroll_glow_config.dart';
import 'core/themes/app_theme.dart';
import 'features/craft_metadata/presentation/pages/track_list_page.dart';
import 'features/craft_metadata/presentation/provider/craft_metadata_provider.dart';
import 'features/craft_metadata/presentation/provider/track_list_provider.dart';
import 'injection.dart';

class AppBase extends StatelessWidget {
  const AppBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<CraftMetadataProvider>()),
        ChangeNotifierProvider(create: (context) => getIt<TrackListProvider>())
      ],
      child: MaterialApp(
        title: 'Album Cover Craft',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark(),
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
