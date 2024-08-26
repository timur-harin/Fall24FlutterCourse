import 'package:flutter/material.dart';

void main() => runApp(const Lab1());

class Lab1 extends StatelessWidget {
  const Lab1({super.key});

  @override
  Widget build(BuildContext context) =>
      const MaterialApp(home: LAb1HomePage());
}

class LAb1HomePage extends StatelessWidget {
  const LAb1HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Lab 1'),
        ),
        body: myWidget(),
      );

  Widget myWidget() =>
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            exercise1(),
            const SizedBox(height: 25),
            exercise2(),
            const SizedBox(height: 25),
            exercise3(),
            const SizedBox(height: 25),
            exercise4(),
            const SizedBox(height: 25),
            exercise5(),
            const SizedBox(height: 25),
          ],
        ),
      );

  Widget exercise1() =>
      const Text(
        'Hello, Flutter!',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFFCA33FF),
        ),
      );

  Widget exercise2() =>
      const Icon(
        Icons.icecream,
        size: 128,
        color: Color(0xFFFFE333),
      );

  Widget exercise3() =>
      const Image(
        image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVLl8BiY-frBPZV4m1fTBaHrex836G4LyVKA&s'),
        width: 128,
        height: 256,
        fit: BoxFit.fill,
      );

  Widget exercise4() =>
      TextButton(
        onPressed: () => print('Pressed'),
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                ),
            ),
        ),
        child: const Text(
            'Press',
            style: TextStyle(color: Colors.white),
        ),
      );

  Widget exercise5() =>
      Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
              margin: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
              decoration: const BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                )
              ),
              child: const Text("Some text"),
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
            margin: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )
            ),
            child: const Icon(Icons.adb, color: Colors.greenAccent),
          ),
        ],
      );
}
