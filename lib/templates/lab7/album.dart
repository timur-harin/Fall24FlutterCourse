import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) =>
      Album(
        userId: json['userId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
      );
}
