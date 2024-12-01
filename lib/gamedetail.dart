import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'api_service.dart';

class GameDetailsScreen extends StatelessWidget {
  final int gameId;
  final ApiService _apiService = ApiService();

  GameDetailsScreen({required this.gameId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Details'),
      ),
      body: FutureBuilder(
        future: _apiService.fetchGameDetails(gameId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details available.'));
          } else {
            final game = snapshot.data as Map<String, dynamic>;
            final unescape = HtmlUnescape();
            final description = unescape
                .convert(game['description'] ?? 'No description available.');

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (game['background_image'] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        game['background_image'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    game['name'] ?? 'Unknown Title',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rating: ${game['rating']?.toStringAsFixed(1) ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
