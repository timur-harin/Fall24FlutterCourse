import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';
part 'album.g.dart';

// TODO code generate class with needed parameters from
// https://jsonplaceholder.typicode.com/albums/1
@freezed
class Album with _$Album {
  factory Album({
    required int userId,
    required int id,
    required String title,
  }) = _Album;

  factory Album.fromJson(Map<String, Object?> json) => _$AlbumFromJson(json);
}
