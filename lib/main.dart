import 'package:flutter/material.dart';
import 'presentation/ui/pages/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferences.setMockInitialValues({});

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
