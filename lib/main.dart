import 'package:flutter/material.dart';
import 'package:lesson3/widgets/auth/auth_widget.dart';
import 'package:lesson3/widgets/mainScreen/main_screen_widget.dart';

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
              AppBarTheme(backgroundColor: Color.fromRGBO(3, 37, 65, 1)),
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/auth': (context) => AuthWidget(),
          '/main_screen': (context) => MainScreenWidget(),
        },
        initialRoute: '/auth',
        // home: const AuthWidget(),
        onGenerateRoute: (RouteSettings routesettings) {
          return MaterialPageRoute<void>(builder: (context) {
            return Scaffold(
              body: Center(child: Text('Произошла ошибка навигации')),
            );
          });
        });
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
