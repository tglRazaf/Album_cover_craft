import 'package:album_cover_craft/core/constants/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/craft_metadata_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    Provider.of<CraftMetadataProvider>(context, listen: false)
        .init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Cover Craft'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<CraftMetadataProvider>(
              builder: (context, provider, _) {
                switch (provider.status) {
                  case Status.error:
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Une erreur s\'est produite',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                        ),
                      ),
                    );
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        provider.file == null
                            ? 'Auccune audio'
                            : 'Success audio',
                        style: TextStyle(
                          fontSize: 24,
                          color: provider.file == null
                              ? Colors.black
                              : Colors.green,
                        ),
                      ),
                    );
                }
              },
            ),
            TextButton(
              onPressed: () {
                Provider.of<CraftMetadataProvider>(context, listen: false)
                    .pickFile();
              },
              child: const Text('Get music'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<CraftMetadataProvider>(context, listen: false)
                    .updateCoverAlbum();
              },
              child: const Text('Update album Cover'),
            ),
          ],
        ),
      ),
    );
  }
}
