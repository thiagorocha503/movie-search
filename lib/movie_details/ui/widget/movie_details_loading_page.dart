import 'package:flutter/material.dart';

class MovieDetailsLoadingPage extends StatelessWidget {
  const MovieDetailsLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
