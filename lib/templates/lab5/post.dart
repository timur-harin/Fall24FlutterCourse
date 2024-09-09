import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor for creating a new `Post` instance from a map
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  // Method to convert the `Post` instance to a map
  Map<String, dynamic> toJson() => _$PostToJson(this);
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
