import 'package:flutter/material.dart';

void main() => runApp(const Lab1());

class Lab1 extends StatelessWidget {
  const Lab1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LAb1HomePage(),
    );
  }
}

class LAb1HomePage extends StatelessWidget {
  const LAb1HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Lab 1'),
      ),
      body: myWidget(),
    );
  }

  Widget myWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          exercise1(),
          const SizedBox(
            height: 25,
          ),
          exercise2(),
          const SizedBox(
            height: 25,
          ),
          exercise3(),
          const SizedBox(
            height: 25,
          ),
          exercise4(),
          const SizedBox(
            height: 25,
          ),
          exercise5(),
        ],
      ),
    );
  }

  Widget exercise1() {
    return const Text(
      "Hello, Flutter!",
      style: TextStyle(
        fontSize: 40,
        color: Colors.red,
        fontWeight: FontWeight.normal),
        );
  }

  Widget exercise2() {
    return const Icon(
      Icons.access_time,
      size: 200,
      color: Colors.green,
    );
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    return const Image(
      width: 50, 
      height: 50, 
      image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'), 
      fit: BoxFit.cover,
    );
  }

  printMessage() {
    print("Pressed");
  }

  Widget exercise4() {
    return TextButton(
      onPressed: printMessage,
      child: const Text('Click here'),
      );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          color: Colors.yellow,
           margin: const EdgeInsets.all(80), 
           padding: const EdgeInsets.all(10), 
           child: const Text("Some text in the container")
           ),
        Container(
          color: Colors.green, 
          margin: const EdgeInsets.all(80), 
          padding: const EdgeInsets.all(100), 
          child: const Icon(Icons.access_time)
          ),
      ]
    );
  }
}
