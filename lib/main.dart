import 'package:flutter/material.dart';
import 'package:lesson3/Theme/app_colors.dart';
import 'package:lesson3/widgets/auth/auth_widget.dart';
import 'package:lesson3/widgets/main_screen/main_screen_widget.dart';
import 'package:lesson3/widgets/movie_details/movie_details_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

      routes: {
        '/auth': (context) => const AuthWidget(),
        '/main_screen': (context) => const MainScreenWidget(),
        '/main_screen/movie_details': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return MovieDetailsWidget(
              movieId: arguments,
            );
          }
          return const MovieDetailsWidget(
            movieId: 0,
          );
        },
      },
      initialRoute: '/auth',
      // home: const AuthWidget(),
      // onGenerateRoute: (RouteSettings routesettings) {
      //   return MaterialPageRoute<void>(builder: (context) {
      //     return const Scaffold(
      //       body: Center(child: Text('Произошла ошибка навигации')),
      //     );
      //   });
      // }
    );
  }
}

// class ExampleWidget extends StatefulWidget {
//   const ExampleWidget({super.key});

//   @override
//   State<ExampleWidget> createState() => _ExampleWidgetState();
// }

// class _ExampleWidgetState extends State<ExampleWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop();
            // if(Navigator.of(context).canPop())
            // {
            //   Navigator.of(context).pop();
            // }
//           },
//           child: Text('push me'),
//         ),
//       ),
//     );
//   }
// }
