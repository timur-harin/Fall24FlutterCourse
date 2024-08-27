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
      fontSize: 24.0,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
  );
}

  Widget exercise2() {
  return const Icon(
    Icons.home,
    size: 100.0,
    color: Colors.green,
  );
}

  Widget exercise3() {
  return const Image(
    image: NetworkImage('https://avatars.mds.yandex.net/i?id=8ad703201bb24b7e67bfbdfa350e27221cdc38e9-11920434-images-thumbs&n=13'),
    width: 200.0,
    height: 150.0,
    fit: BoxFit.cover,
  );
}

  Widget exercise4() {
  return TextButton(
    onPressed: () {
      print('Pressed');
    },
    child: const Text('Press Me'),
  );
}

  Widget exercise5() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          'Hello, Flutter!',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          border: Border.all(color: Colors.orange, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Icon(
          Icons.thumb_up,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    ],
  );
}
}
