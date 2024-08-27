import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
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
    return const Text("Hello Flutter!", style: TextStyle(fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold));
  }

  Widget exercise2() {
    return const Icon(Icons.catching_pokemon, size: 100, color: Colors.red);
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    return Image.network('https://www.meme-arsenal.com/memes/958634784ef9bb39322a28810652347d.jpg', width: 250, height: 200,fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(onPressed: () {
      print("Pressed");
    }, child: const Text('Press this button'));
  }

  Widget exercise5() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.all(10), 
        padding: EdgeInsets.all(10), 
        decoration: BoxDecoration(color: Colors.lightBlue, 
        border: Border.all(color: Colors.deepPurple, width: 1)), 
        child: Text('Hello Flutter!', style: TextStyle(color: Colors.white, fontSize: 20))),
      Container(
        margin: EdgeInsets.all(10), 
        padding: EdgeInsets.all(10), 
        decoration: BoxDecoration(color: Colors.lightBlue, 
        border: Border.all(color: Colors.deepPurple, width: 1)), 
        child: Icon(Icons.monitor, size: 80, color: Colors.white)),
    ]);
  }
}
