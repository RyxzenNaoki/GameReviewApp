import 'package:flutter/material.dart';

void main() {
  runApp(GameUIApp());
}

class GameUIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameHomePage(),
    );
  }
}

class GameHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/nyoba.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Header
          Positioned(
            top: 50,
            left: 20,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Back action
                  },
                ),
                Text(
                  'Game Title',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Character and game elements
          Positioned(
            bottom: 150,
            left: 50,
            right: 50,
            child: Center(
              child: Image.asset(
                'assets/character.png', // Placeholder for game character
                height: 200,
              ),
            ),
          ),
          // Controls UI
          Positioned(
            bottom: 50,
            left: 20,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, size: 48, color: Colors.white),
                  onPressed: () {
                    // Left movement action
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                      size: 48, color: Colors.white),
                  onPressed: () {
                    // Right movement action
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Jump action
              },
              child: Icon(Icons.arrow_upward),
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
