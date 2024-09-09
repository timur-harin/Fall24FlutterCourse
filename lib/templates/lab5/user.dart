import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Map<String, dynamic> address;
  final String phone;
  final String website;
  final Map<String, dynamic> company;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.phone,
      required this.website,
      required this.company});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        address: json['address'],
        phone: json['phone'],
        website: json['website'],
        company: json['company']);
  }
}

Future<List<User>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => User.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
