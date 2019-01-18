import 'package:flutter/material.dart';
import 'package:pokedex/screens/home_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload". The application is not restarted.
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(title: 'Pokedex'),
    );
  }
}
