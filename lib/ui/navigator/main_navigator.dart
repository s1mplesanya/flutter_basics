import 'package:flutter/material.dart';
import 'package:lesson3/ui/widgets/movie_details/movie_details_model.dart';
import 'package:lesson3/ui/widgets/movie_trailer/movie_trailer_widget.dart';

import '../../library/widgets/inherited/notifier_provider.dart';
import '../widgets/auth/auth_model.dart';
import '../widgets/auth/auth_widget.dart';
import '../widgets/main_screen/main_screen_widget.dart';
import '../widgets/movie_details/movie_details_widget.dart';

class MainNavigationRoutesName {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const movieTrailer = '/movie_details/trailer';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRoutesName.mainScreen
      : MainNavigationRoutesName.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesName.auth: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigationRoutesName.mainScreen: (context) => const MainScreenWidget(),
  };

  Route<Object>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutesName.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (context) => NotifierProvider(
                  create: () => MovieDetailsModel(movieId: movieId),
                  child: const MovieDetailsWidget(),
                ));
      case MainNavigationRoutesName.movieTrailer:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
            builder: (context) => MovieTrailerWidget(
                  youtubeKey: youtubeKey,
                ));

      default:
        const widget = Text('Nagivation error!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
