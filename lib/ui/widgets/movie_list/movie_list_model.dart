import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lesson3/domain/api_client/api_client.dart';

import '../../../domain/entity/movie.dart';

class MovieListModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _movies = <Movie>[];

  List<Movie> get movies => List.unmodifiable(_movies);

  late DateFormat _dateFormat;
  String _locale = '';

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  void setUpLocale(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    _movies.clear();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final moviesResponse = await _apiClient.getPopularMovies(1, _locale);
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, int index) {}
}
