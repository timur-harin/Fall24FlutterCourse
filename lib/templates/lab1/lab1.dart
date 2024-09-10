import 'dart:async';

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
            fontSize: 28,
            color: Color.fromARGB(200, 42, 3, 75),
            fontWeight: FontWeight.w300));
  }

  Widget exercise2() {
    return const Icon(
      Icons.home,
      size: 100, // Setting the size of the icon
      color:
          Color.fromARGB(255, 178, 121, 72), // Correct color value with opacity
    );
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    return const Image(
        image: NetworkImage(
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
        width: 98,
        height: 180,
        fit: BoxFit.fill //intentional
        );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print('pressed');
      },
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(const Color.fromARGB(255, 5, 79, 168)),
      ),
      child: const Text("button",
          style: TextStyle(
              fontSize: 28,
              color: Color.fromARGB(255, 240, 236, 243),
              fontWeight: FontWeight.w300)),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.all(10.0), // External margin
            padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 5.0,
                bottom: 5.0), // Internal padding
            decoration: BoxDecoration(
              color: const Color.fromARGB(124, 160, 200, 0), // Background color
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
              border: Border.all(
                color: Color.fromARGB(255, 29, 82, 9), // Border color
                width: 4.0, // Border width
              ),
            ),
            child: const Text("Look \nhere",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    color: Color.fromARGB(255, 138, 99, 0),
                    fontWeight: FontWeight.w100))),
        Container(
          margin: const EdgeInsets.only(bottom: 95.0), // External margin
          child: const Icon(
            Icons.arrow_circle_up_sharp,
            size: 100, // Setting the size of the icon
            color: Color.fromARGB(
                255, 29, 82, 9), // Correct color value with opacity
          ),
        )
      ],
    );
  }
}
