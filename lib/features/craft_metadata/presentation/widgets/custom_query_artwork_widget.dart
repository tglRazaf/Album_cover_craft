import 'package:album_cover_craft/injection.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../provider/craft_metadata_provider.dart';

class CustomQueryArtworkWidget extends StatelessWidget {
  const CustomQueryArtworkWidget(
      {super.key, required this.id, required this.type});

  final int id;
  final ArtworkType type;

  @override
  Widget build(BuildContext context) {
    return Consumer<CraftMetadataProvider>(
      builder: (context, provider, _) {
        return FutureBuilder(
          future: audioQuery.queryArtwork(id, type),
          builder: (context, snapshot) {
            if (!snapshot.hasData && snapshot.data == null) {
              return Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: Colors.white.withOpacity(.1)),
                child: const Icon(Icons.library_music_outlined),
              );
            }
            return Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: snapshot.hasData && snapshot.data != null
                    ? DecorationImage(
                        image: MemoryImage(snapshot.data!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}
