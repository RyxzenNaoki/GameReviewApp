import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://api.rawg.io/api';
  final String _apiKey =
      'a6d191e0e81e4f0cac51929acf568f21'; // Ganti dengan API Key RAWG Anda.

  // Metode umum untuk membuat URI
  Uri _buildUrl(String endpoint, [Map<String, String>? queryParameters]) {
    final Map<String, String> params = {
      'key': _apiKey,
      ...?queryParameters, // Tambahkan parameter tambahan jika ada
    };
    return Uri.parse('$_baseUrl/$endpoint').replace(queryParameters: params);
  }

  // Metode untuk mengambil semua game
  Future<List<dynamic>> fetchGames(
      {String ordering = '-rating', int pageSize = 10}) async {
    final url = Uri.parse(
        '$_baseUrl/games?key=$_apiKey&ordering=$ordering&page_size=$pageSize');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'] as List<dynamic>;
    } else {
      throw Exception('Failed to load games');
    }
  }

  Future<List<dynamic>> fetchGamesByCategory(String category,
      {int pageSize = 10}) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/games?genres=$category&page_size=$pageSize&key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'] ?? [];
    } else {
      throw Exception('Failed to fetch games for category: $category');
    }
  }

  Future<List<dynamic>> fetchLatestGames({int? pageSize, int? page}) async {
    final url = _buildUrl('games', {
      'ordering': '-released', // Mengurutkan berdasarkan tanggal rilis terbaru.
      if (pageSize != null) 'page_size': pageSize.toString(),
      if (page != null) 'page': page.toString(),
    });
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']; // Mengembalikan daftar game terbaru.
    } else {
      throw Exception('Gagal memuat game terbaru: ${response.statusCode}');
    }
  }

  // Metode untuk mendapatkan detail game berdasarkan ID
  Future<Map<String, dynamic>> fetchGameDetails(int gameId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/games/$gameId?key=$_apiKey'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch game details');
    }
  }
}
