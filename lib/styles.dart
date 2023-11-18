import "package:flutter/material.dart";

// Background Colors
Color bgColor = const Color.fromARGB(255, 25, 35, 45);
Color backButtonBG = const Color.fromARGB(255, 20, 30, 40);

List<Color> colorGradient = [
  Color.fromARGB(255, 40, 50, 60),
  Color.fromARGB(255, 26, 81, 95),
];

// Text Colors
Color unselectedOptionColor = Color.fromARGB(255, 40, 50, 60);
Color topicText = Colors.white70;
Color buttonText = Colors.white;
const Color menuTextHeadingColor = Colors.white;
Color menuTextBodyColor = Colors.white60;

// Component Background Colors
Color topicBackground =
    Colors.cyan.shade700; // A slightly different shade from the main bg
Color buttonBackground = Colors.cyan.shade700; // Using cyan to bring attention

ButtonStyle exploreButtonStyle = ElevatedButton.styleFrom(
  primary: buttonBackground, // Using the color defined above
  onPrimary: buttonText,
  textStyle: TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  ),
  padding: EdgeInsets.all(16.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24.0),
  ),
  elevation: 5.0,
);
