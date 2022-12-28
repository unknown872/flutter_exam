import 'package:flutter/material.dart';
import 'package:crud_api/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/home": (context) => const Home(),
      },
      initialRoute: "/home",
      debugShowCheckedModeBanner: false,
    );
  }
}
