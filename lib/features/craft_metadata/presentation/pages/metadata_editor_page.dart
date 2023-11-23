import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../injection.dart';
import '../../domain/entities/music_entity.dart';
import '../provider/craft_metadata_provider.dart';

class MetadataEditorPage extends StatefulWidget {
  const MetadataEditorPage({super.key, required this.targetMusic});

  final MusicEntity targetMusic;

  @override
  State<MetadataEditorPage> createState() => _MetadataEditorPageState();
}

class _MetadataEditorPageState extends State<MetadataEditorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<CraftMetadataProvider>(context, listen: false)
                .clearModification();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Edit'),
        actions: [
          Consumer<CraftMetadataProvider>(
            builder: (context, provider, _) => provider.status == Status.loading
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      Provider.of<CraftMetadataProvider>(context, listen: false)
                          .updateCoverAlbum();
                    },
                    icon: const Icon(Icons.check),
                  ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Consumer<CraftMetadataProvider>(
                      builder: (context, provider, _) => FutureBuilder(
                          future: audioQuery.queryArtwork(
                            widget.targetMusic.metadata.id,
                            ArtworkType.AUDIO,
                          ),
                          builder: (context, snapshot) {
                            return Container(
                              width: MediaQuery.sizeOf(context).width * .4,
                              height: 150,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white54),
                                borderRadius: BorderRadius.circular(10),
                                image: provider.cover != null
                                    ? DecorationImage(
                                        image: FileImage(provider.cover!),
                                        fit: BoxFit.cover,
                                      )
                                    : snapshot.data != null
                                        ? DecorationImage(
                                            image: MemoryImage(
                                              snapshot.data!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Provider.of<CraftMetadataProvider>(context,
                                            listen: false)
                                        .addNewCoverPhoto();
                                  },
                                  icon: const Icon(Icons.image_outlined),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.targetMusic.trackName,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              widget.targetMusic.artistName,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.75)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 24),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.sizeOf(context).width, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text('Load from remote'),
                ),
              ),
              const CustomTextField(
                
              ),
              const CustomTextField(),
            ],
          ),
        ),
      ),
    );
  }
}
