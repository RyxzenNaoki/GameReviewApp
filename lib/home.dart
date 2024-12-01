import 'package:flutter/material.dart';
import 'category.dart';
import 'header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Header(),
            const Category(),
          ],
        ),
      ),
    );
  }
}
