import 'package:auto_route/auto_route.dart';
import 'package:fall_24_flutter_course/templates/lab5/app_router/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter status_code number: ',
            ),
          ),
          
          MaterialButton(
            onPressed: () => context.pushRoute(
              CatRoute(statusCode: _controller.text),
            ),
            child: const Text('Navigate to cat status_code page!'),
          ),
        ],
      ),
    ));
  }
}
