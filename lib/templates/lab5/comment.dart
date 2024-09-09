import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  // Factory constructor for creating a `Comment` instance from a map
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

Future<List<Comment>> fetchComments() async {
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> commentsJson = jsonDecode(response.body);
    return commentsJson.map((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}
