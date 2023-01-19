import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lesson3/domain/services/movie_service.dart';
import 'package:lesson3/library/widgets/paginator.dart';
import 'package:lesson3/ui/navigator/main_navigator.dart';

import '../../../domain/entity/movie.dart';

class MovieListRowData {
  final int id;
  final String title;
  final String releaseDate;
  final String overview;
  final String? posterPath;

  MovieListRowData({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
  });
}

class MovieListViewModel extends ChangeNotifier {
  final _movieService = MovieService();
  late Paginator<Movie> _popularMoviePaginator;
  late Paginator<Movie> _searchMoviePaginator;
  Timer? searchDebounce;
  String _locale = '';

  var _movies = <MovieListRowData>[];
  String? _searchQuery;

  List<MovieListRowData> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;

  bool get isSearchMode {
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  MovieListViewModel() {
    _popularMoviePaginator = Paginator<Movie>((page) async {
      final result = await _movieService.popularMovie(page, _locale);
      return PaginatorLoadResult(
          data: result.movies,
          currentPage: result.page,
          totalPage: result.totalPages);
    });

    _searchMoviePaginator = Paginator<Movie>((page) async {
      final result =
          await _movieService.searchMovie(page, _locale, _searchQuery ?? '');
      return PaginatorLoadResult(
          data: result.movies,
          currentPage: result.page,
          totalPage: result.totalPages);
    });
  }

  Future<void> setUpLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);

    await _resetList();
  }

  Future<void> _loadNextPage() async {
    if (isSearchMode) {
      await _searchMoviePaginator.loadNextPage();
      _movies = _searchMoviePaginator.data.map(_makeRowData).toList();
    } else {
      await _popularMoviePaginator.loadNextPage();
      _movies = _popularMoviePaginator.data.map(_makeRowData).toList();
    }
    notifyListeners();
  }

  MovieListRowData _makeRowData(Movie movie) {
    final releaseDate = movie.releaseDate;
    final releaseDateTitle =
        releaseDate != null ? _dateFormat.format(releaseDate) : '';
    return MovieListRowData(
      id: movie.id,
      title: movie.title,
      releaseDate: releaseDateTitle,
      overview: movie.overview,
      posterPath: movie.posterPath,
    );
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRoutesName.movieDetails, arguments: id);
  }

  void showMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }

  Future<void> _resetList() async {
    await _popularMoviePaginator.resetList();
    await _searchMoviePaginator.resetList();
    _movies.clear();
    await _loadNextPage();
  }

  Future<void> searchMovie(String text) async {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(seconds: 1), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (searchQuery == _searchQuery) return;
      _searchQuery = searchQuery;

      _movies.clear();
      if (isSearchMode) {
        await _searchMoviePaginator.resetList();
      }
      _loadNextPage();
    });
  }
}
