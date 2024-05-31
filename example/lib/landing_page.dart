import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the file containing the ChatPage.

import 'main.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        toolbarHeight: 100, // Increase the toolbar height to 150 pixels.
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.only(top: 50), // Add top padding here
          child: Text(
            'Welome to MusicAI',
            style: TextStyle(
              color: Color.fromARGB(255, 58, 165, 252),
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/robot.svg'), // Display the SVG image.
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 58, 165, 252)
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
              child: const Text('Let\'s learn',
               style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
               ),
              ),
            ),
          ],
        ),
      ),
    );
}