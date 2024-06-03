// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'main.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF1D1836), // Background color with hex code
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text with Inter font in white color.
            Text(
              'Start your musical journey',
              style: TextStyle(fontSize: 32, fontFamily: 'Inter-Extraligh', color: Colors.white),
            ),
            Text(
              'with',
              style: TextStyle(fontSize: 32, fontFamily: 'Inter', color: Colors.white),
            ),
            // Text with Chopin Script font in white color.
            Text(
              'Lila',
              style: TextStyle(fontSize: 64, fontFamily: 'Chopin Script', color: Colors.white),
            ),
            // Centered image with container for size control.
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset(
                  'wallpaper.png',
                  fit: BoxFit.cover, // Adjust as needed (cover, contain, etc.)
                ),
              ),
            ),
            // Buttons in a column with padding and spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust as needed
              child: Column(
                children: [
                  // Add spacing between buttons
                  SizedBox(height: 50.0), // Adjust spacing as needed

                  ElevatedButton(
                    onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      foregroundColor: Colors.white, // Text color
                      backgroundColor: Color(0xFF482E99), // Button background color
                    ),
                    child: Text('Let\'s Learn'),
                  ),
                  SizedBox(height: 50.0), // Adjust spacing as needed

                  ElevatedButton(
                    onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      backgroundColor: Colors.white, // Text color
                      foregroundColor: Color.fromRGBO(29, 24, 54, 1), // Button background color
                    ),
                    child: Text('Take Quiz'),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}