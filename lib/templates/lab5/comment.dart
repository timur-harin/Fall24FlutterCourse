import 'package:dio/dio.dart';
import 'package:fall_24_flutter_course/templates/lab5/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

// void main() async {
//   print(await fetchComments());
// }

@JsonSerializable()
class Comment {
  // TODO task 2 to make this class for url http://jsonplaceholder.typicode.com/comments

  const Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  @override
  String toString() =>
      'Comment(\n\tpostId: $postId\n\tid: $id\n\tname: $name\n\temail: $email\n\tbody: $body\n)';
}

Future<List<Comment>> fetchComments() async {
  final Response response = await getData('http://jsonplaceholder.typicode.com/comments');

  final List<Comment> comments = [];

  for (dynamic commentJson in response.data as List<dynamic>) {
    comments.add(Comment.fromJson(commentJson as Map<String, dynamic>));
  }

  return comments;
}
