import 'package:app_calorias/calculadorapage.dart';
import 'package:app_calorias/loginpage.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: const MyHomePage(),
      initialRoute: '/',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 20, 20, 20)),
      routes: {
        '/': (context) => const LoginPage(),
        '/mainPage': (context) => const MainPage(),
        '/calculadora': (context) => const Calculadora(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}