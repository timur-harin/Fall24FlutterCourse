import 'package:flutter/material.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

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
    return Text("Hello Flutter!", style: TextStyle(fontSize: 40, color: Colors.red, fontWeight: FontWeight.bold));
  }

  Widget exercise2() {
    return Icon(Icons.home, size: 50, color: Colors.blue);
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    return Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg', width: 70, height: 70, fit: BoxFit.cover);
  }

  Widget exercise4() {
    return TextButton(onPressed: () {
      print('Pressed');
    }, 
    child: Text('Tap me'),);
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          child: Text("I am the first child"),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.pink),
        ),
        Container(
          child: Icon(Icons.home),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.blue)
        )
      ],
    );
  }
}
