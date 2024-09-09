// TODO add dependencies
import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  print(await fetchPosts());
}

class Post {
  // TODO task 1 to make this class for url http://jsonplaceholder.typicode.com/posts
  Post(
    this.userId,
    this.id,
    this.title,
    this.body
  );

  final int userId;
  final int id;
  final String title;
  final String body;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json['userId'], json['id'], json['title'], json['body']);
  }

  Map<String, dynamic> toJson(Post post) {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['userId'] = post.userId;
    json['id'] = post.id;
    json['title'] = post.title;
    json['body'] = post.body;
    return json;
  }


}

Future<List<Post>> fetchPosts() async {
  final response = jsonDecode((await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))).body) as List<dynamic>;
  final List<Post> result = [];
  for (dynamic json in response) {
    Map<String, dynamic> postJson = json as Map<String, dynamic>;
    result.add(Post.fromJson(postJson));
  }
  // TODO task 1.2 to make this function for url http://jsonplaceholder.typicode.com/posts
  // // Using fabric from class
  return result;
}
