import 'package:flutter/material.dart';
import 'package:lesson3/my_app/my_app_model.dart';

import '../Theme/app_colors.dart';
import '../ui/navigator/main_navigator.dart';

class MyApp extends StatelessWidget {
  final MyAppModel model;
  static final mainNavigation = MainNavigation();
  const MyApp({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme:
              const AppBarTheme(backgroundColor: AppColors.mainDarkBlue),
          primarySwatch: Colors.blue,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: AppColors.mainDarkBlue),
          selectedRowColor: Colors.white,
          unselectedWidgetColor: Colors.grey),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
