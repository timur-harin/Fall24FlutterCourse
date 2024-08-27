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
        fontSize: 30.0,
        color: Color.fromARGB(255, 124, 4, 134),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.youtube_searched_for,
      size: 50.0,
      color: Color.fromARGB(255, 124, 4, 134),
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://i.imgur.com/AXSTny2.jpeg',
      width: 300.0,
      height: 200.0,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print('Pressed');
      },
      child: Text('Feed Him'),
    );
  }

  Widget exercise5() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 251, 187, 251),
          border: Border.all(color: const Color.fromARGB(255, 124, 4, 134), width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'His name is McNuggets',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.green[100],
          border: Border.all(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Icon(
          Icons.thumb_up,
          size: 40.0,
          color: Colors.green,
        ),
      ),
    ],
  );
}
}

