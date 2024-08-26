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
    return const Text("Hello Flutter!",
    style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 100,
      color: Colors.blue,
    );
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    return Image.network(
    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    width: 200,
    height: 200,
    fit: BoxFit.cover,
  );
  }

  Widget exercise4() {
    return TextButton(onPressed: () { 
      print("Pressed");
    },
    child: const Text('Free money!'),
  );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
        padding: const EdgeInsets.all(20.0), // Padding inside the container
        margin: const EdgeInsets.only(left: 10.0), // Margin below the container
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2.0), // Border around the container
          color: const Color.fromARGB(255, 171, 221, 114), // Background color
        ),
        child: const Text(
          'Hello, World!',
          style: TextStyle(fontSize: 30),
        ),
        ),
      Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(top: 8.0), // Margin above the container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          color: Colors.blue.shade200, // Background color
        ),
        child: const Icon(
          Icons.favorite,
          size: 42,
          color: Colors.red,
        ),
      ),
      ],
    );
  }
}
