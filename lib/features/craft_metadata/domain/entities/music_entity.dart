import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicEntity extends Equatable {
  final String filePath;
  final Uint8List? albumCover;
  final SongModel metadata;

  const MusicEntity({
    required this.filePath,
    this.albumCover,
    required this.metadata,
  });

  String get trackName {
    return metadata.title;
  }

  String get artistName {
    return metadata.artist ?? 'Unknown Artist';
  }

  @override
  List<Object?> get props => [filePath, albumCover, metadata];

  MusicEntity copyWith({
    String? filePath,
    Uint8List? albumCover,
    SongModel? metadata,
  }) {
    return MusicEntity(
      filePath: filePath ?? this.filePath,
      albumCover: albumCover ?? this.albumCover,
      metadata: metadata ?? this.metadata,
    );
  }

  static Future<MusicEntity> fromSongModel(SongModel song) async {
    return MusicEntity(
      filePath: song.data,
      metadata: song,
    );
  }
}
