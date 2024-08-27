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
    style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.favorite,
      color: Colors.red,
      size: 24.0
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () { 
        print("Pressed");
      },
      child: const Text('Press me'),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20.0), 
          margin: const EdgeInsets.only(left: 20.0), 
          decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 5.0), 
            color: const Color.fromARGB(255, 200, 122, 98), 
          ),
          child: const Text(
            'Wow',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24.0),
          margin: const EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), 
            color: Colors.green.shade300, 
          ),
          child: const Icon(
            Icons.favorite,
            size: 60,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}