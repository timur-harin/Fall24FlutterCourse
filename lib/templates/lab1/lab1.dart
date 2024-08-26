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
        fontSize: 40,
        color: Colors.blue,
        fontWeight: FontWeight.bold 
      ),);
  }

  Widget exercise2() {
    return const Icon(
      Icons.rocket_launch,
      size: 50,
      color: Colors.blue
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://www.mos.ru/upload/newsfeed/newsfeed/belka-i-strelka-posle-poleta.jpg',
      width: 200,
      // height: 100,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print('Pressed');
      },
      child: const Text('pup'),
      );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            color: Colors.blue,
          ),
          child: const Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            color: Colors.blue,
          ),
          child: const Icon(
            Icons.rocket_sharp,
            size: 50,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}