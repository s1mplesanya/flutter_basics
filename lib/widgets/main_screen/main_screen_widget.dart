import 'package:flutter/material.dart';

import '../movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedPage = 0;

  void onSelectPage(int index) {
    if (_selectedPage == index) return;
    setState(() {
      _selectedPage = index;
    });
  }

  static const List<Widget> pages = <Widget>[
    Text('Новости'),
    MovieListWidget(),
    Text('Сериалы'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
      ),
      body: Center(
        child: pages[_selectedPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper), label: "Новости"),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_filter), label: "Фильмы"),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: "Сериалы"),
          ],
          onTap: onSelectPage),
    );
  }
}
