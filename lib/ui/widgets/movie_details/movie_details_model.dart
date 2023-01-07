import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lesson3/domain/entity/movie_details.dart';

import '../../../domain/api_client/api_client.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _apiClient = ApiClient();

  final int movieId;
  String _locale = '';
  MovieDetails? _movieDetails;
  late DateFormat _dateFormat;

  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsModel({
    required this.movieId,
  });

  Future<void> setUpLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);

    await getMovieDetails();
  }

  String stringFromDate(DateTime dateTime) =>
      dateTime != null ? _dateFormat.format(dateTime) : '';

  Future<void> getMovieDetails() async {
    _movieDetails = await _apiClient.movieDetails(movieId, _locale);
    notifyListeners();
  }
}
