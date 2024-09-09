// TODO add dependencies
import 'dart:convert';

import 'package:http/http.dart' as http;
// TODO add user.g.dart as part
// TODO add user.freezed.dart as part
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.g.dart';
part 'main.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
    required Address address,
    required String phone,
    required String website,
    required Company company,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // TODO task 3 to make this class for url http://jsonplaceholder.typicode.com/users/
}

Future<List<User>> fetchUsers() async {
  // TODO task 3.2 to make this function for url http://jsonplaceholder.typicode.com/users/
  // Using fabric from class
  final response =
      await http.get(Uri.parse(' http://jsonplaceholder.typicode.com/users/ '));
  if (response.statusCode == 200) {
    // Parse the response body as a List of dynamic objects (JSON data)
    List<dynamic> postsJson = jsonDecode(response.body);

    // Map the JSON data to a List of Post objects using the Post.fromJson factory
    return postsJson.map((json) => User.fromJson(json)).toList();
  } else {
    // If the request fails, throw an exception
    throw Exception('Failed to load posts');
  }

  return [];
}

@freezed
class Address with _$Address {
  const factory Address({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    required Geo geo,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@freezed
class Geo with _$Geo {
  const factory Geo({
    required String lat,
    required String lng,
  }) = _Geo;

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);
}

@freezed
class Company with _$Company {
  const factory Company({
    required String name,
    required String catchPhrase,
    required String bs,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
