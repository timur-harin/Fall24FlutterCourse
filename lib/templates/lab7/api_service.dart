import 'dart:convert';
import 'package:fall_24_flutter_course/templates/lab7/album.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Album> fetchAlbum(http.Client client) async {

    // TODO get response using client from https://jsonplaceholder.typicode.com/albums/1
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    
    // TODO add status check and throw exception
    if (response.statusCode == 200) {
      // TODO add json parsing Album.fromJson
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // TODO Add throwing exception
      throw Exception('Failed to load album');
    }
  }
}

