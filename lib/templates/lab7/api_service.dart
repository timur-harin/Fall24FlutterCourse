import 'dart:convert';

import 'package:fall_24_flutter_course/templates/lab7/album.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Album> fetchAlbum(http.Client client) async {

    // TODO get response using client from https://jsonplaceholder.typicode.com/albums/1
    
    // TODO add status check and throw exception
    if (true) {
      // TODO add json parsing Album.fromJson
      return Album.fromJson();
    } else {
      // TODO Add throwing exception
    }
  }
}

