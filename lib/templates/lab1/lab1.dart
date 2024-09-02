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
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 12,
        color: Colors.blueGrey,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.ice_skating_outlined,
      size: 30,
      color: Colors.blueGrey
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmCy16nhIbV3pI1qLYHMJKwbH2458oiC9EmA&s',
      fit: BoxFit.cover,
      width: 100.0,
      height: 100.0,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () => print('Pressed'),
      child: const Text('This button prints "Pressed" message to the console!'),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: Border.all(
              color: Colors.red,
              width: 8.0,
            ) + Border.all(
              color: Colors.green,
              width: 8.0,
            ) + Border.all(
              color: Colors.blue,
              width: 8.0,
            ),
          ),
          child: const Text('Container with Text widget'),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.rectangle,
          ),
          child: const Icon(Icons.access_alarm),
        ),
      ],
    );
  }
}
