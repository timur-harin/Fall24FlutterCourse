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
    return const Text("Hello Flutter!", style: TextStyle(fontSize: 32, color: Colors.red, fontWeight: FontWeight.w500));
  }

  Widget exercise2() {
    return const Icon(Icons.account_box, size: 120, color: Colors.red);
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    return Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', width: 150, height: 150, fit: BoxFit.fill);
  }

  Widget exercise4() {
    return TextButton(onPressed: () {print("Pressed");}, child: const Text("Press the button"));
  }

  Widget exercise5() {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(13),
        margin: const EdgeInsets.symmetric(horizontal: 13),
        decoration: const BoxDecoration(color: Colors.red),
        child: const Text("Container 1 in Column"),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: const Icon(Icons.mood, size: 60, color: Colors.red),
      )
    ],)
    ;
  }
}
