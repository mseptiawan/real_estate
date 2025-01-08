import 'package:flutter/material.dart';
import 'package:real_estate/screens/login.screen.dart';
import 'package:real_estate/screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/navigation_screen.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/register',
      routes: {
        '/': (context) => const NavigationScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
