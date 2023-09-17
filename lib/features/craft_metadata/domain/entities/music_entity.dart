import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:path/path.dart' as path;

class MusicEntity extends Equatable {
  final String filePath;
  final Metadata metadata;

  const MusicEntity({
    required this.filePath,
    required this.metadata,
  });

  String get trackName {
    return metadata.trackName ?? path.basename(filePath);
  }

  @override
  List<Object> get props => [filePath, metadata];

  MusicEntity copyWith({
    String? filePath,
    Metadata? metadata,
  }) {
    return MusicEntity(
      filePath: filePath ?? this.filePath,
      metadata: metadata ?? this.metadata,
    );
  }

  static Future<MusicEntity> fromPath(String path) async {
    final metadata = await MetadataRetriever.fromFile(File(path));
    return MusicEntity(filePath: path, metadata: metadata);
  }
}
