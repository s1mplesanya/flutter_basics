// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lesson3/domain/api_client/account_api_client.dart';
import 'package:lesson3/domain/api_client/api_client_exteption.dart';
import 'package:lesson3/domain/data_providers/session_data_provider.dart';
import 'package:lesson3/domain/entity/movie_details.dart';
import 'package:lesson3/domain/entity/movie_details_credits.dart';
import 'package:lesson3/domain/services/auth_service.dart';
import 'package:lesson3/ui/navigator/main_navigator.dart';

import '../../../domain/api_client/movie_api_client.dart';

class MovieDetailsPosterData {
  final String? backdropPath;
  final String? posterPath;
  final IconData favoriteIcon;

  MovieDetailsPosterData({
    this.backdropPath,
    this.posterPath,
    this.favoriteIcon = Icons.favorite_outline,
  });
}

class MovieNameData {
  final String name;
  final String year;
  MovieNameData({
    required this.name,
    required this.year,
  });
}

class MovieScoreData {
  final double voteAverage;
  final String? trailerKey;
  MovieScoreData({
    required this.voteAverage,
    this.trailerKey,
  });
}

class MoviePeopleCrewData {
  final String name;
  final String job;

  MoviePeopleCrewData({
    required this.name,
    required this.job,
  });
}

class MovieActorData {
  final String name;
  final String character;
  final String? profilePath;

  MovieActorData({
    required this.name,
    required this.character,
    this.profilePath,
  });
}

class MovieDetailsData {
  String title = "";
  bool isLoading = true;
  String overview = "";
  MovieDetailsPosterData posterData = MovieDetailsPosterData();
  MovieNameData nameData = MovieNameData(name: '', year: '');
  MovieScoreData scoreData = MovieScoreData(voteAverage: 0);
  String summary = '';
  List<List<MoviePeopleCrewData>> crewData =
      const <List<MoviePeopleCrewData>>[];

  List<MovieActorData> actorsData = const <MovieActorData>[];
}

class MovieDetailsModel extends ChangeNotifier {
  final _authService = AuthService();
  final _sessionDataProvider = SessionDataProvider();
  final _movieApiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();

  final data = MovieDetailsData();

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
    updateData(null, false);
    await getMovieDetails(context);
  }

  String stringFromDate(DateTime dateTime) =>
      dateTime != null ? _dateFormat.format(dateTime) : '';

  Future<void> getMovieDetails(BuildContext context) async {
    try {
      _movieDetails = await _movieApiClient.movieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      }
      updateData(_movieDetails, _isFavorite);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void updateData(MovieDetails? details, bool isFavorite) {
    data.title = details?.title ?? "Loading...";
    data.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }
    data.overview = details.overview ?? '';

    final iconData = isFavorite ? Icons.favorite : Icons.favorite_outline;
    data.posterData = MovieDetailsPosterData(
      favoriteIcon: iconData,
      backdropPath: details.backdropPath,
      posterPath: details.posterPath,
    );

    var year = details.releaseDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    data.nameData = MovieNameData(name: details.title, year: year);

    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'Youtube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    data.scoreData = MovieScoreData(
        voteAverage: details.voteAverage, trailerKey: trailerKey);

    data.summary = makeSummary(details);
    data.crewData = makeCrewData(details);
    data.actorsData = details.credits.cast
        .map((e) => MovieActorData(
            name: e.name, character: e.character, profilePath: e.profilePath))
        .toList();

    notifyListeners();
  }

  String makeSummary(MovieDetails details) {
    var texts = <String>[];
    final releaseDate = details.releaseDate;
    if (releaseDate != null) {
      texts.add(_dateFormat.format(releaseDate));
    }

    if (details.productionCountries.isNotEmpty) {
      texts.add('(${details.productionCountries.first.iso})');
    }
    final runtime = details.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    texts.add('${duration.inHours}h ${duration.inMinutes}m');

    if (details.genres.isNotEmpty) {
      final genresNames = <String>[];
      for (var gern in details.genres) {
        genresNames.add(gern.name);
      }
      texts.add(genresNames.join(', '));
    }
    return texts.join();
  }

  List<List<MoviePeopleCrewData>> makeCrewData(MovieDetails details) {
    var crew = details.credits.crew
        .map((e) => MoviePeopleCrewData(job: e.job, name: e.name))
        .toList();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<MoviePeopleCrewData>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks
          .add(crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }

    return crewChunks;
  }

  Future<void> toggleFavorite(BuildContext context) async {
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
      _handleApiClientException(e, context);
    }
  }

  void _handleApiClientException(
      ApiClientException exception, BuildContext context) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        _authService.logout();
        MainNavigation.resetNavigation(context);
        break;
      default:
        break;
    }
  }
}
