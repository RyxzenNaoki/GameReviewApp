import 'package:flutter/material.dart';
import 'api_service.dart';
import 'gamedetail.dart';

class GamesByCategoryScreen extends StatelessWidget {
  final String category;
  final ApiService _apiService = ApiService();

  GamesByCategoryScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Games'),
      ),
      body: FutureBuilder(
        future: _apiService.fetchGamesByCategory(category.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No games found.'));
          } else {
            final games = snapshot.data as List<dynamic>;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
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
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          game['background_image'] ?? '',
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                      title: Text(game['name']),
                      subtitle: Text((game['genres'] as List<dynamic>)
                          .map((genre) => genre['name'])
                          .join(', ')),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
