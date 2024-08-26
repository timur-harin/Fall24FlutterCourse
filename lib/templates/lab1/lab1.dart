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
        style: TextStyle(
          fontSize: 40,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w700,
        ));
  }

  Widget exercise2() {
    return const Icon(
      Icons.adb_outlined,
      size: 60,
      color: Colors.green
    );
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget exercise4() {
    return Center(
      child: TextButton(
          onPressed: () {
            print('Pressed!');
          },
          child: const Text('press me pls')),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            border: Border.all(color: Colors.purple, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Home icon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(color: Colors.black26, width: 3.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: const Icon(
            Icons.home,
            size: 40,
            color: Colors.black26,
          ),
        ),
      ],
    );
  }
}
