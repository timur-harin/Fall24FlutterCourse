import 'dart:convert';

import 'package:fall_24_flutter_course/templates/lab7/album.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  Future<Album> fetchAlbum(http.Client client) async {
    final Response response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    // TODO add status check and throw exception
    if (response.statusCode == 200) {
      return Album.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load album!');
    }
  }
}
