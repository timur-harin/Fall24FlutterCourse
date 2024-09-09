import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart';

part 'comment.g.part';

@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments
  final String name;
  final String email;
  final String body;
  final int id;
  final int postId;

  Comment({required this.postId, required this.id, required this.name, required this.email, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class

  Response res = await get(Uri.http('jsonplaceholder.typicode.com/posts'));
  List<Map<String, dynamic>> postsJson = jsonDecode(res.body);
  return postsJson.map((post) => Comment.fromJson(post)).toList();
}
