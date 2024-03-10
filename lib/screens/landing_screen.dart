import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //transparent can be done by opacity but performance intensive
        Image.asset(
          'assets/images/flower.png',
          width: 300,
        ),

        const SizedBox(
          height: 50,
        ),

        const Text(
          '   We deliver\nplants at your\n   door step',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 22, 22, 22),
              letterSpacing: 4,
              fontWeight: FontWeight.bold),
        ),

        const SizedBox(
          height: 30,
        ),
        // const Icon(Icons.quiz_outlined),

        OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 126, 106, 215),
          ),
          icon: const Icon(Icons.arrow_forward),
          label: const Text(
            'Buy',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    ));
  }
}
