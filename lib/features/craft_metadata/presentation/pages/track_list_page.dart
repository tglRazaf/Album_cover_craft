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
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final music = provider.musics[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey),
                          padding: const EdgeInsets.all(8),
                          width: 50,
                          child: music.metadata.picture != null
                              ? Image.memory(music.metadata.picture!.data)
                              : Image.asset('assets/images/album_cover.jpg'),
                        ),
                        title: Text('${music.metadata.title}'),
                        subtitle: Text('${music.metadata.artist}'),
                        trailing: const Icon(Icons.more_vert_outlined),
                      ),
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
