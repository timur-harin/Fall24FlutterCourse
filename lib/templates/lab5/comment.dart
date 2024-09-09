import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:http/http.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}


Future<List<Comment>> fetchComments() async {
  final response = await get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}
