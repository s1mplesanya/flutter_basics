import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lesson3/domain/api_client/account_api_client.dart';
import 'package:lesson3/domain/api_client/api_client_exteption.dart';
import 'package:lesson3/domain/data_providers/session_data_provider.dart';
import 'package:lesson3/domain/entity/movie_details.dart';

import '../../../domain/api_client/movie_api_client.dart';

class MovieDetailsModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _movieApiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();

  final int movieId;
  String _locale = '';
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  late DateFormat _dateFormat;

  MovieDetails? get movieDetails => _movieDetails;
  bool get isFavorite => _isFavorite;

  Future<void>? Function()? onSessionExpired;

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
    try {
      _movieDetails = await _movieApiClient.movieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      }

      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  Future<void> toggleFavorite() async {
    final accountId = await _sessionDataProvider.getAccountId();
    final sessionId = await _sessionDataProvider.getSessionId();

    if (accountId == null || sessionId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();
    try {
      await _accountApiClient.markAsFavorite(
          accountId: accountId,
          sessionId: sessionId,
          mediaType: MediaType.movie,
          mediaId: movieId,
          isFavorite: _isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    }
  }

  void _handleApiClientException(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        onSessionExpired?.call();
        break;
      default:
        break;
    }
  }
}
