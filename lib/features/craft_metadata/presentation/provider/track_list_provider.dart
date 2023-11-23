import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/status.dart';
import '../../../../injection.dart';
import '../../domain/entities/music_entity.dart';

class TrackListProvider extends ChangeNotifier {
  
  Status status;
  List<MusicEntity> musics = [];

  TrackListProvider({
    this.status = Status.loading,
  });

  Future<void> init() async {
    await requestPermission();
    await queryAudioFiles();
  }

  Future<void> requestPermission() async {
    await Permission.storage.request();
    await Permission.accessMediaLocation.request();
    await Permission.audio.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> queryAudioFiles() async {
    status = Status.loading;
    notifyListeners();
    List<SongModel> audios =
        await audioQuery.querySongs(sortType: SongSortType.TITLE);
    for (var i = 0; i < audios.length; i++) {
      musics.add(await MusicEntity.fromSongModel(audios[i]));
    }
    status = Status.loaded;
    notifyListeners();
  }
}
