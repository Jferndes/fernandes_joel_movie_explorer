import 'package:flutter/material.dart';

import 'package:fernandes_joel_movie_explorer/models/movie.dart';
import 'package:fernandes_joel_movie_explorer/services/tmdb_service.dart';
import 'package:fernandes_joel_movie_explorer/widgets/movie_card.dart';

//Ecran d'acceuil : listes des films
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];
  final TmdbService _tmdbService = TmdbService();

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