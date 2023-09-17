import 'package:equatable/equatable.dart';
import 'package:metadata_god/metadata_god.dart';

class MusicEntity extends Equatable {
  final String filePath;
  final Metadata metadata;
  const MusicEntity({
    required this.filePath,
    required this.metadata,
  });

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
    final data = await MetadataGod.readMetadata(file: path);
    return MusicEntity(filePath: path, metadata: data);
  }
}
