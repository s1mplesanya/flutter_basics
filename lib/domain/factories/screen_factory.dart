import 'package:flutter/material.dart';
import 'package:lesson3/library/widgets/inherited/notifier_provider.dart'
    as old_provider;
import 'package:lesson3/ui/widgets/auth/auth_model.dart';
import 'package:lesson3/ui/widgets/auth/auth_widget.dart';
import 'package:lesson3/ui/widgets/loader/loader_model.dart';
import 'package:lesson3/ui/widgets/loader/loader_widget.dart';
import 'package:lesson3/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:lesson3/ui/widgets/movie_details/movie_details_model.dart';
import 'package:lesson3/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:lesson3/ui/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return old_provider.NotifierProvider(
      create: () => AuthModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  Widget makeMovieDetails(int movieId) {
    return old_provider.NotifierProvider(
      create: () => MovieDetailsModel(movieId: movieId),
      child: const MovieDetailsWidget(),
    );
  }

  Widget makeMovieTrailer(String youtubeKey) {
    return MovieTrailerWidget(
      youtubeKey: youtubeKey,
    );
  }
}
