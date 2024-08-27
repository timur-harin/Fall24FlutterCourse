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
        leading: const Icon(Icons.stars),
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
      style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 25, color: Colors.red),
    );
  }

  Widget exercise2() {
    return const Icon(
      Icons.abc_sharp,
      size: 52,
      color: Colors.black,
    );
  }

  Widget exercise3() {
    return Image.network(
      'https://pichold.ru/wp-content/uploads/2019/06/05-09-8158890_1.jpg',
      width: 300,
      height: 200,
      fit: BoxFit.cover,
    );

  }

  Widget exercise4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {
            print("Pressed");
          },
          child: const Text('Tap me to see "Pressed"'),

        ),
      ],
    );

  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5) ,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange),
            color: const Color.fromARGB(255, 216, 160, 100),
          ),
          child: const Text(
            'White Cat',
            style: TextStyle(fontSize: 27),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            color: Colors.white,
          ),
          child: const Icon(Icons.access_alarm, color: Colors.grey),
        ),
      ],


    );
  }
}