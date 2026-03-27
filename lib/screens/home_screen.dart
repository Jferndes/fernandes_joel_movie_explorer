import 'package:flutter/material.dart';

import 'package:fernandes_joel_movie_explorer/models/movie.dart';
import 'package:fernandes_joel_movie_explorer/services/tmdb_service.dart';
import 'package:fernandes_joel_movie_explorer/widgets/movie_card.dart';
import 'package:fernandes_joel_movie_explorer/screens/movie_detail_screen.dart';

//Ecran d'acceuil : listes des films
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];
  final TmdbService _tmdbService = TmdbService();
  int _currentPage = 1;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchMovies(_currentPage);
  }

  Future<void> _fetchMovies(int page) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final fetchedMovies = await _tmdbService.fetchPopularMovies(page: page);
      setState(() {
        movies = fetchedMovies;
        _currentPage = page;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur lors du chargement: Veillez réssayer';
        _isLoading = false;
      });
    }
  }

  Widget _refresh() {
    return FloatingActionButton(
      onPressed: () => _fetchMovies(_currentPage),
      tooltip: 'Rafraîchir',
      child: const Icon(Icons.refresh),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );

    }else if (_errorMessage != null) {

      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(_errorMessage!, style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ),
        floatingActionButton: _refresh(),
      );
    
    }else {
      return Scaffold(
        body: ListView.separated(
          itemCount: movies.length,
          separatorBuilder: (context, index) => Divider(), 
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieCard(
              movie: movie,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
                );
              }
            );
          },
        ),
        
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: (_currentPage > 1) ? () => _fetchMovies(_currentPage - 1) : null,
                  child: const Text('Précédent'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _fetchMovies(_currentPage + 1),
                  child: const Text('Suivant'),
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: _refresh(),
      );
    }
  }
}