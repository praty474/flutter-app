import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //transparent can be done by opacity but performance intensive
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 300,
          color: const Color.fromARGB(148, 232, 227, 227),
        ),

        const SizedBox(
          height: 50,
        ),

        const Text(
          'Learn Flutter the fun way!',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 137, 123, 225),
          ),
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
          icon: const Icon(Icons.quiz_outlined),
          label: const Text('Start Quiz'),
        ),
      ],
    ));
  }
}
