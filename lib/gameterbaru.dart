import 'package:flutter/material.dart';
import 'api_service.dart';

const Color kPrimary = Colors.blue;

class GameTerbaru extends StatelessWidget {
  final ApiService _apiService = ApiService();

  GameTerbaru({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Game Terbaru',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder(
            future: _fetchFilteredGames(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No games with images found.'));
              } else {
                final games = snapshot.data as List<dynamic>;
                return ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return _listItem(
                      game['background_image'],
                      game['name'] ?? 'Unknown Title',
                      game['genres'].isNotEmpty
                          ? game['genres'][0]['name']
                          : 'Unknown Genre',
                      game['released'] ?? 'Unknown Date',
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  /// Fetch and filter games with valid images
  Future<List<dynamic>> _fetchFilteredGames() async {
    final games = await _apiService.fetchLatestGames(pageSize: 10);
    // Filter only games with valid image URLs
    return games
        .where((game) =>
            game['background_image'] != null &&
            game['background_image']!.isNotEmpty)
        .toList();
  }

  Container _listItem(String url, String judul, String genre, String rilis) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              url,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(genre),
                        const SizedBox(height: 2),
                        Text(rilis),
                      ],
                    ),
                    const Spacer(),
                    _tombolMain(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _tombolMain() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Text(
        'Mainkan',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
