import 'package:flutter/material.dart';
import 'package:flutter_assngmnt/bottom_navbar.dart';

void main() {
  runApp(const Bar());
}

class Bar extends StatelessWidget {
  const Bar({super.key});
  
  @override
   Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavbarScreen(),
    );
  }
}