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
      "HelloWorld!",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.green
      )
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.replay_outlined,
      color: Color(0xFFCCCCCC),
      size: 100
    );
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    return Image.network(
      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
      width: 100,
      height: 60,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () { print('Button is pressed'); },
      child: const Text("Pressed")
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        // first container has padding, second - margin, so we can see difference
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          child: const Text("Home")
        ),
        Container(
          // padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          margin: const EdgeInsets.all(10),
          child: const Icon(Icons.home)
        )
      ]
    );
  }
}
