import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'features/craft_metadata/domain/usecases/pick_image_from_gallery_usecase.dart';
import 'features/craft_metadata/presentation/provider/craft_metadata_provider.dart';
import 'features/craft_metadata/presentation/provider/track_list_provider.dart';

final getIt = GetIt.instance;
late final String baseUrl;
final OnAudioQuery audioQuery = OnAudioQuery();
final saveDir = Directory('/storage/emulated/0/Music/ACC/');
final baseDir = Directory('/storage/emulated/0/');

Future<void> init() async {
  await dotenv.load(fileName: '.env');
  usecases();
  registerProviders();
}

void registerProviders() {
  getIt.registerLazySingleton(
    () => CraftMetadataProvider(
      baseDir: baseDir,
      saveDir: saveDir,
      pickImageFromGallery: getIt<PickImageFromGalleryUsecase>(),
    ),
  );
  getIt.registerLazySingleton(
    () => TrackListProvider(),
  );
}

void usecases() {
  getIt.registerLazySingleton(() => PickImageFromGalleryUsecase());
}
