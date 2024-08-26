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
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.flutter_dash,
      size: 200,
      color: Colors.blueAccent,
    );
  }

  Widget exercise3() {
      const String imageUrl = 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';

    return const Image(
      image: NetworkImage(imageUrl),
      width: 200,
      height: 180,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print('Pressed');
      },
      child: const Text(
      'Press Me',
      style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            border: Border.all(
              color: Colors.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Tweet!',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green[50],
            border: Border.all(
              color: Colors.green,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Icon(
            Icons.energy_savings_leaf_rounded,
            size: 50,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

}
