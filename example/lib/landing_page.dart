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
              style: TextStyle(fontSize: 32, fontFamily: 'Inter', color: Colors.white),
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
                width: 350,
                height: 350,
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
                  SizedBox(height: 20.0), // Adjust spacing as needed

                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatPage()),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      foregroundColor: Colors.white, // Text color
                      backgroundColor: Color(0xFF482E99), // Button background color
                      minimumSize: Size(100, 50), // Set minimum size for both width and height
                    ),
                    child: Text(
                      'Let\'s Learn',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32), // Make text bold
                    ),
                  ),
                  SizedBox(height: 20.0), // Adjust spacing as needed

                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatPage()),
                      
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      backgroundColor: Colors.white, // Text color
                      foregroundColor: Color(0xFF482E99), // Button background color
                      minimumSize: Size(100, 50), // Set minimum size for both width and height
                    ),
                    child: Text(
                      'Let\'s Play',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32), // Make text bold
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
