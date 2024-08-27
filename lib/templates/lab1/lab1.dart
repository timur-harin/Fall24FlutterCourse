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
    return Text(
      'Hello Flutter!',
      style: TextStyle(
        fontSize: 22,
        color: Colors.deepOrangeAccent,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget exercise2() {
    return Icon(
      Icons.music_video,
      size: 100,
      color: Colors.amber,
    );
  }



  Widget exercise3() {
    return Image.network(
      'https://fakeimg.pl/500x500/?text=Lab01',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print("Pressed");
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 199, 61, 187),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Color.fromARGB(255, 255, 152, 250),
            width: 0.2,
          ),
        ),
      ),
      child: Text('Just a Button'),
    );
  }

  Widget exercise5() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.greenAccent,
              width: 1.2,
            ),
            color: Colors.blueAccent[100],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            'idk what to write',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.yellowAccent,
              width: 1.8,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.horizontal(right: Radius.zero),
          ),
          child: Icon(
            Icons.backpack,
            size: 50,
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }
}
