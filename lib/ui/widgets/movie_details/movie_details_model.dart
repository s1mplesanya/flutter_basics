import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lesson3/domain/data_providers/session_data_provider.dart';
import 'package:lesson3/domain/entity/movie_details.dart';

import '../../../domain/api_client/api_client.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();

  final int movieId;
  String _locale = '';
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  late DateFormat _dateFormat;

  MovieDetails? get movieDetails => _movieDetails;
  bool get isFavorite => _isFavorite;

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
    final sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null) {
      _isFavorite = await _apiClient.isFavorite(movieId, sessionId);
    }

    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (accountId == null || sessionId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();
    await _apiClient.markAsFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: MediaType.Movie,
        mediaId: movieId,
        isFavorite: _isFavorite);
  }
}
