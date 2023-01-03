import 'package:flutter/material.dart';

import '../widgets/auth/auth_model.dart';
import '../widgets/auth/auth_widget.dart';
import '../widgets/main_screen/main_screen_widget.dart';
import '../widgets/movie_details/movie_details_widget.dart';

class MainNavigationRoutesName {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRoutesName.mainScreen
      : MainNavigationRoutesName.auth;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesName.auth: (context) => AuthProvider(
          model: AuthModel(),
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
            builder: (context) => MovieDetailsWidget(
                  movieId: movieId,
                ));
      default:
        const widget = Text('Nagivation error!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
