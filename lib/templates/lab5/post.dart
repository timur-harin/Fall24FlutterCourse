import 'dart:convert';
import 'package:http/http.dart';

class Post {
  int userId;
  int id;
  String title;
  String body;
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body
    };
  }
}

Future<List<Post>> fetchPosts() async {
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  Response res = await get(Uri.http('jsonplaceholder.typicode.com/posts'));
  List<Map<String, dynamic>> postsJson = jsonDecode(res.body);
  return postsJson.map((post) => Post.fromJson(post)).toList();
}
