import 'package:lesson3/configuration/configuration.dart';
import 'package:lesson3/domain/api_client/movie_api_client.dart';
import 'package:lesson3/domain/entity/popular_movie_response.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();

  Future<PopularMovieResponse> popularMovie(int page, String language) async =>
      _movieApiClient.getPopularMovies(page, language, Configuration.apiKey);

  Future<PopularMovieResponse> searchMovie(
          int page, String language, String query) async =>
      _movieApiClient.searchMovies(page, language, query, Configuration.apiKey);
}
