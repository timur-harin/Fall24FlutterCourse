import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cats are awesome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/cat': (context) => CatPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => UndefinedPage());
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter status code',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              child: Text('Go to Cat Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/cat',
                    arguments: _controller.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CatPage extends StatefulWidget {
  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  late Future<Uint8List> futureImage;

  @override
  Widget build(BuildContext context) {
    final String statusCode =
        ModalRoute.of(context)!.settings.arguments as String;
    futureImage = _fetchImage('https://http.cat/$statusCode');

    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Page'),
      ),
      body: Center(
        child: FutureBuilder<Uint8List>(
          future: futureImage,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Image.memory(snapshot.data!);
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<Uint8List> _fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image.');
    }
  }
}

class UndefinedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Undefined Page'),
      ),
      body: Center(
        child: Text('This is an undefined page.'),
      ),
    );
  }
}
