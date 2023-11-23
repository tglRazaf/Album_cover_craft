import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/status.dart';
import '../provider/craft_metadata_provider.dart';
import '../provider/track_list_provider.dart';
import '../widgets/custom_query_artwork_widget.dart';
import 'metadata_editor_page.dart';

class TrackListPage extends StatefulWidget {
  const TrackListPage({super.key});

  @override
  State<TrackListPage> createState() => _TrackListPageState();
}

class _TrackListPageState extends State<TrackListPage> {

  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Provider.of<TrackListProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Tracks'),
      ),
      body: Consumer<TrackListProvider>(
        builder: (context, provider, child) {
          if (provider.status == Status.loading) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return Scrollbar(
            controller: _scrollController,
            interactive: true,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final music = provider.musics[index];
                      return ListTile(
                        tileColor: Colors.black,
                        leading: CustomQueryArtworkWidget(
                          id: music.metadata.id,
                          type: ArtworkType.AUDIO,
                        ),
                        title: Text(music.trackName, maxLines: 1),
                        subtitle: Text(
                          music.artistName,
                          style:
                              TextStyle(color: Colors.white.withOpacity(.75)),
                        ),
                        trailing: PopupMenuButton(
                          child: Container(
                            height: 36,
                            width: 48,
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.more_vert),
                          ),
                          itemBuilder: (context) => items
                              .map(
                                (e) => PopupMenuItem(
                                  onTap: () {},
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                        ),
                        onTap: () {
                          Provider.of<CraftMetadataProvider>(context,
                                  listen: false)
                              .setTargetMusic(music);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MetadataEditorPage(
                                targetMusic: music,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: provider.musics.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CraftMetadataProvider>(context, listen: false).callKotlin();
        },
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
