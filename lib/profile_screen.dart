import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text('Profile Page')),
    );
  }
}
