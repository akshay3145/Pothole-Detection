import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}); // ❌ no const needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Text(
          "Welcome",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
