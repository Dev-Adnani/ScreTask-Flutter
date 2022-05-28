import 'package:flutter/material.dart';
import 'package:scretask/presentation/homeScreen/home.screen.dart';

class AppRouter {
  static const String homeRoute = "/home";

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
    }
    return null;
  }
}
