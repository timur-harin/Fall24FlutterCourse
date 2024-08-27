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
      "Hello Flutter!", style: 
      TextStyle(fontSize: 20, color: Colors.black, 
                fontWeight: FontWeight.bold)
      );
  }

  Widget exercise2() {
    return const Icon(
      Icons.pallet, size: 150, color: Color.fromARGB(255, 31, 0, 117)
      );
  }

  Widget exercise3() {
    // Example for image from internet 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
    //
    return Image.network(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPEUWiBWszJdp_fmVauQELNoBaDEdSFk_crs-CPaP2vnDj3cKupiarbTGsVSYFzXy4pPg&usqp=CAU', 
      width: 250, height: 250,fit: BoxFit.cover
      );
  }

  Widget exercise4() {
    return TextButton(
      onPressed: () {
        print("Pressed");
      }, 
      child: const Text(
        'Press me', style: TextStyle(
          fontSize: 20, color: Colors.black, 
          fontWeight: FontWeight.bold)));
  }

  Widget exercise5() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.all(15), 
        padding: EdgeInsets.all(15), 
        decoration: BoxDecoration(
          color: Colors.lightBlue, 
          border: Border.all(color: Colors.blue, width: 5),
          borderRadius: BorderRadius.circular(7)
        ), 
        child: Text('Flutter', style: TextStyle(color: Colors.white, fontSize: 20))),
      Container(
        margin: EdgeInsets.all(15), 
        padding: EdgeInsets.all(15), 
        decoration: BoxDecoration(
          color: Colors.yellow, 
          border: Border.all(color: Colors.orange, width: 7)
        ), 
        child: Icon(Icons.apartment, size: 100, color: Colors.red)),
    ]);
  }
}
