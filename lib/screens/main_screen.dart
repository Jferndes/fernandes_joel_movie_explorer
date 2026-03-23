import 'package:flutter/material.dart';
import 'package:fernandes_joel_movie_explorer/screens/home_screen.dart';
import 'package:fernandes_joel_movie_explorer/screens/search_screen.dart';
import 'package:fernandes_joel_movie_explorer/screens/favorites_screen.dart';


//Ecran qui gère la navigation principal
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(),
      SearchScreen(),
      FavoritesScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      // BottomNavigationBar (slide 57)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.deepPurple,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
      ),
    );
  }
}