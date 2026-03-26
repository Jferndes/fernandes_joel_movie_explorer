import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class TmdbService {
  static const String _apiKey = '26c9c4ce7109897bbc2bcf3c837d12c0';
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _jwtToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmM5YzRjZTcxMDk4OTdiYmMyYmNmM2M4MzdkMTJjMCIsIm5iZiI6MTc3MzkzMzgwOS4xNTI5OTk5LCJzdWIiOiI2OWJjMTRmMTFkZWExYTFjNjUwMGY0ZTciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.7tzr5afRix77f2wpUnh6yF28QleZV0qWjxHCw9UZTJw';

  //Récupérer les films pour la liste du menu principal
  Future<List<Movie>> fetchPopularMovies({int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/movie/popular?language=fr-FR&page=$page',);

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_jwtToken'
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      return results.map((item) => Movie.fromJson(item as Map<String, dynamic>)).toList();
    }else{
      throw Exception('Erreur HTTP: ${response.statusCode}');
    }
  }
  
  // Recherche de films par mot clé
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/search/movie?language=fr-FR&query=$query&page=$page');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_jwtToken'
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      return results.map((item) => Movie.fromJson(item as Map<String, dynamic>)).toList();
    }else{
      throw Exception('Erreur HTTP: ${response.statusCode}');
    }
    
  }

}