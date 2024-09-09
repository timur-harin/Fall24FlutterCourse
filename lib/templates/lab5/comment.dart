import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

// JSON serializable part file
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
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

Future<List<Comment>> fetchComments() async {
  final response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/comments'));
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Comment.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}
