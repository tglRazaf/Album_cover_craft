import 'dart:io';
import 'package:album_cover_craft/core/usecase/usecase.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import '../../../../core/constants/status.dart';
import '../../domain/entities/music_entity.dart';
import '../../domain/usecases/pick_image_from_gallery_usecase.dart';

class CraftMetadataProvider extends ChangeNotifier {
  static const platform = MethodChannel('flutter.native/helper');

  Status status;
  File? cover;
  MusicEntity? targetMusic;
  final Directory saveDir;
  final Directory baseDir;
  final PickImageFromGalleryUsecase pickImageFromGallery;

  CraftMetadataProvider({
    this.status = Status.init,
    this.cover,
    required this.saveDir,
    this.targetMusic,
    required this.baseDir,
    required this.pickImageFromGallery,
  });

  Future<void> initDir() async {
    if (!saveDir.existsSync()) {
      await saveDir.create(recursive: true);
    }
  }

  void setTargetMusic(MusicEntity music) {
    targetMusic = music;
  }

  Future<void> init() async {
    await initDir();
  }

  Future<void> addNewCoverPhoto() async {
    cover = await pickImageFromGallery(NoParam());
    notifyListeners();
  }

  Future<void> updateCoverAlbum() async {
    if (cover != null && targetMusic != null) {
      if (!cover!.existsSync()) {
        return print('---------File not exist');
      }
      final fileName = path.basename(targetMusic!.filePath);
      final outPutPath =
          '${saveDir.path.replaceAll(RegExp(r'\s+'), '')}$fileName';
      status = Status.loading;

      notifyListeners();
      try {
        final command = await FFmpegKit.execute(
          '''-y -i "${targetMusic!.filePath}" -i "${cover?.path}" -c copy -map 0 -map 1 -map_metadata 0 "$outPutPath"''',
        );
        final returnCode = await command.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          await File(targetMusic!.filePath).delete();
          final tmpFile = File(outPutPath);
          await tmpFile.rename(targetMusic!.filePath);
          print('---------------success conversion');
          status = Status.loaded;
        } else if (ReturnCode.isCancel(returnCode)) {
          print('---------------conversion canceled');
          status = Status.init;
        } else {
          final logs = await command.getLogs();
          for (var log in logs) {
            print('----------log : ${log.getMessage()}');
          }
          status = Status.error;
        }
      } on Exception catch (e) {
        print('an erro occured $e');
        status = Status.error;
      }
      notifyListeners();
    } else {
      print('---------user canceled');
    }
  }

  void clearModification() {
    cover = null;
  }

  Future<void> callKotlin() async {
    try {
      final String result = await platform.invokeMethod("callKotlin", {
        "message": 'Hello method channel',
      });
      print('RESULT -> $result');
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
