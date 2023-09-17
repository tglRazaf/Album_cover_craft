import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/status.dart';
import '../provider/craft_metadata_provider.dart';

class TrackListPage extends StatefulWidget {
  const TrackListPage({super.key});

  @override
  State<TrackListPage> createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CraftMetadataProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Tracks'),
      ),
      body: Consumer<CraftMetadataProvider>(
        builder: (context, provider, child) {
          if (provider.status == Status.loading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return CustomScrollView(
            controller: provider.scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final music = provider.musics[index];
                    return ListTile(
                      tileColor: Colors.black,
                      leading: Container(
                        decoration: BoxDecoration(
                          image: music.metadata.albumArt != null
                              ? DecorationImage(
                                  image: MemoryImage(music.metadata.albumArt!),
                                  fit: BoxFit.cover)
                              : const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/album_cover.jpg',
                                  ),
                                    fit: BoxFit.cover
                                ),
                        ),
                        padding: const EdgeInsets.all(8),
                        width: 50,
                      ),
                      title: Text(music.trackName),
                      subtitle: Text(
                          music.metadata.albumArtistName ?? 'Unknown Artist'),
                      trailing: const Icon(Icons.more_vert_outlined),
                    );
                  },
                  childCount: provider.musics.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
