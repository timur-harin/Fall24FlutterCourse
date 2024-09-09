import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    // Parse the response body as a List of dynamic objects (JSON data)
    List<dynamic> postsJson = jsonDecode(response.body);

    // Map the JSON data to a List of Post objects using the Post.fromJson factory
    return postsJson.map((json) => Post.fromJson(json)).toList();
  } else {
    // If the request fails, throw an exception
    throw Exception('Failed to load posts');
  }
}
