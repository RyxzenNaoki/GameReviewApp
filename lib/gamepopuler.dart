import 'package:flutter/material.dart';
import 'api_service.dart';
import 'gamedetail.dart';

class GamePopuler extends StatelessWidget {
  final ApiService _apiService = ApiService();

  GamePopuler({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Game Populer',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        FutureBuilder(
          future: _apiService.fetchGames(ordering: '-rating', pageSize: 10),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No games found.'));
            } else {
              final games = snapshot.data as List<dynamic>;
              return SizedBox(
                height: 200, // Diperkecil dari 300 menjadi 200
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GameDetailsScreen(gameId: game['id']),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: _listItem(
                          game['background_image'] ?? '',
                          game['name'],
                          (game['genres'] as List<dynamic>)
                              .map((genre) => genre['name'])
                              .join(', '),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _listItem(String imageUrl, String title, String genres) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 250, // Lebar item diperkecil dari 250 menjadi 150
        height: 150, // Tinggi item diperkecil dari 300 menjadi 200
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              right: 10,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14, // Ukuran font lebih kecil
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Text(
                genres,
                style: const TextStyle(
                  fontSize: 12, // Ukuran font lebih kecil
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
