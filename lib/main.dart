import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

import 'package:fernandes_joel_movie_explorer/models/movie.dart';
import 'package:fernandes_joel_movie_explorer/services/tmdb_service.dart';
import 'package:fernandes_joel_movie_explorer/widgets/movie_card.dart';

//Point d'entrée de l'application
void main() {
  runApp(const MovieExplorerApp());
}

class MovieExplorerApp extends StatelessWidget {
  const MovieExplorerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Explorer',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final TmdbService _tmdbService = TmdbService();
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      final fetchedMovies = await _tmdbService.fetchPopularMovies(page: 2);
       setState(() {
        movies = fetchedMovies;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, 
        title: Text('Movie explorer'),
      ),

      body: ListView.separated(
        itemCount: movies.length,
        separatorBuilder: (context, index) => Divider(), 
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie);
        }
      ),
    );
  }
}
