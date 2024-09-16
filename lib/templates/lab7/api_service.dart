import 'dart:convert';

import 'package:fall_24_flutter_course/templates/lab7/album.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Album> fetchAlbum(http.Client client) async {
    final response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/albums/1')
    );

    return switch (response.statusCode) {
      200 => Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>),
      _ => throw Exception('Failed to load album'),
    };
  }
}

