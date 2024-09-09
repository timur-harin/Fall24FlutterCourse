import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'main.gr.dart';

// Define routes for your app using AutoRoute
// @MaterialAutoRouter(
//   replaceInRouteName: 'Page,Route',
//   routes: [
//     AutoRoute(
//       path: '/',
//       page: HomePage,
//     ),
//     AutoRoute(
//       path: '/cat/:statusCode',
//       page: CatImagePage,
//     ),
//   ],
// )

// Define routes for your app using AutoRoute
// @AdaptiveAutoRouter(
//   replaceInRouteName: 'Page,Route',
//   routes: [
//     AutoRoute(
//       path: '/',
//       page: HomePage,
//     ),
//     AutoRoute(
//       path: '/cat/:statusCode',
//       page: CatImagePage,
//     ),
//   ],
// )
class AppRouter extends _$AppRouter {}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cat Status Codes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: AppRouter().delegate(),
      routeInformationParser: AppRouter().defaultRouteParser(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _statusCodeController = TextEditingController();

  @override
  void dispose() {
    _statusCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Status Codes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _statusCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Status Code',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a status code.';
                  }
                  final statusCode = int.tryParse(value);
                  if (statusCode == null || statusCode < 100 || statusCode > 599) {
                    return 'Invalid status code. Please enter a valid code between 100 and 599.';
                  }
                                    return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigate to CatImagePage using AutoRoute with argument
                    context.router.pushNamed(
                      '/cat/${_statusCodeController.text}',
                    );
                  }
                },
                child: Text('Fetch Cat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CatImagePage widget to display the image
class CatImagePage extends StatefulWidget {
  final int statusCode;

  const CatImagePage({Key? key, required this.statusCode}) : super(key: key);

  @override
  _CatImagePageState createState() => _CatImagePageState();
}

class _CatImagePageState extends State<CatImagePage> {
  String? _imageUrl;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  Future<void> _fetchImage() async {
    final response =
        await http.get(Uri.parse('https://http.cat/${widget.statusCode}'));

    if (response.statusCode == 200) {
      setState(() {
        _imageUrl = response.request!.url.toString();
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = 'Error fetching image. Please try again later.';
        _imageUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageUrl != null)
              Image.network(_imageUrl!),
            if (_errorMessage != null)
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}