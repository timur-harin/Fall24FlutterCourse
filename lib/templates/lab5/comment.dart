// TODO add dependencies
// TODO add comment.g.dart as part
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body
});

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  //Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Do not forget to run 'dart run build_runner build' to generate comment.g.dart
}

Future<List<Comment>> fetchComments() async {
  // TODO task 2.2 to make this function for url http://jsonplaceholder.typicode.com/comments
  // // Using fabric from class
  final response = jsonDecode((await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'))).body) as List<dynamic>;
  final List<Comment> result = [];
  for (dynamic json in response) {
    Map<String, dynamic> postJson = json as Map<String, dynamic>;
    result.add(Comment.fromJson(postJson));
  }
  return result;
}
