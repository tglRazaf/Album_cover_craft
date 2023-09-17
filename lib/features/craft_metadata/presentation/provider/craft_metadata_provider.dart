import 'dart:io';
import 'dart:typed_data';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/constants/status.dart';
import '../../domain/entities/music_entity.dart';

class CraftMetadataProvider extends ChangeNotifier {
  Status status = Status.init;
  File? file;
  File? cover;
  final dir = Directory('/storage/emulated/0/Music/ACC/');
  final musicDir = Directory('/storage/emulated/0/');
  final files = <File>[];
  final directories = <Directory>[];
  int directoryIndex = 0;
  late ScrollController scrollController;
  final musics = <MusicEntity>[];

  Future<void> initDir() async {
    await requestPermission();
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
  }

  Future<void> init() async {
    scrollController = ScrollController();
    await initDir();
    await getDirectoryFiles();
  }

  Future<void> requestPermission() async {
    await Permission.storage.request();
    await Permission.accessMediaLocation.request();
    await Permission.audio.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> getDirectoryFiles() async {
    status = Status.loading;
    notifyListeners();

    if (musicDir.existsSync()) {
      await fetchBaseDirectories();
      if (directoryIndex < directories.length) {
        for (var fileSysEntity
            in directories[directoryIndex].listSync(recursive: true)) {
          if (fileSysEntity is File &&
              path.extension(fileSysEntity.path).toLowerCase() == '.mp3') {
            musics.add(await MusicEntity.fromPath(fileSysEntity.path));
          }
        }
        directoryIndex++;
      }
    }

    status = Status.loaded;
    notifyListeners();
  }

  Future<void> fetchBaseDirectories() async {
    for (var fileSysEntity in musicDir.listSync(recursive: false)) {
      if (fileSysEntity is Directory &&
          !fileSysEntity.path.contains('/storage/emulated/0/Android')) {
        directories.add(fileSysEntity);
      }
    }
  }

  Future<void> pickFile() async {
    final res = await FilePicker.platform.pickFiles();
    if (res != null) {
      file = File(res.files.single.path!);
      status = Status.loaded;
      notifyListeners();
    }
  }

  Future<File?> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  Future<Uint8List> readAssetFile(String assetPath) async {
    final ByteData data =
        await rootBundle.load('assets/images/album_cover.jpg');
    return data.buffer.asUint8List();
  }

  Future<void> updateCoverAlbum() async {
    // ffmpeg -i input.mp3 -i cover.png -c copy -map 0 -map 1 output.mp3
    cover = await pickImage();

    if (cover != null && file != null) {
      // final fileExtension = path.extension(file!.path);
      if (!cover!.existsSync()) {
        return print('---------File not exist');
      }

      final fileName = path.basename(file!.path);
      final outPutPath = '${dir.path.replaceAll(RegExp(r'\s+'), '')}$fileName';
      status = Status.loading;

      print(
          '---------------input : ${file?.path},\n---------------output : ${dir.path.replaceAll(RegExp(r'\s+'), '')}cover_$fileName,\n---------------cover : ${cover!.path}');
      notifyListeners();
      try {
        final command = await FFmpegKit.execute(
          '''-y -i "${file?.path}" -i "${cover?.path}" -c copy -map 0 -map 1 -map_metadata 0 "$outPutPath"''',
        );
        final returnCode = await command.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          // SUCCESS
          status = Status.loaded;
          print('---------------success conversion');
        } else if (ReturnCode.isCancel(returnCode)) {
          // CANCEL
          status = Status.init;
          print('---------------conversion canceled');
        } else {
          // ERROR
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
}
