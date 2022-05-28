import 'package:flutter/material.dart';
import 'package:scretask/presentation/homeScreen/home.screen.dart';
import 'package:scretask/presentation/splashScreen/splash.screen.dart';
import 'package:scretask/presentation/taskScreens/createTaskScreen/create.tasks.screen.dart';
import 'package:scretask/presentation/taskScreens/healthTaskScreen/health.tasks.screen.dart';
import 'package:scretask/presentation/taskScreens/noTaskScreen/no.tasks.screen.dart';
import 'package:scretask/presentation/taskScreens/personalTaskScreen/personal.tasks.screen.dart';
import 'package:scretask/presentation/taskScreens/workTaskScreen/work.tasks.screen.dart';

class AppRouter {
  static const String homeRoute = "/home";
  static const String splashRoute = "/splash";
  static const String healthTaskRoute = "/health";
  static const String workTaskRoute = "/work";
  static const String personalTaskRoute = "/personal";
  static const String createTaskRoute = "/create";
  static const String noTaskRoute = "/noTask";

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
      case splashRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
          );
        }
      case healthTaskRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const HealthTaskScreen(),
          );
        }
      case workTaskRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const WorkTaskScreen(),
          );
        }
      case personalTaskRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const PersonalTaskScreen(),
          );
        }
      case createTaskRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const CreateTaskScreen(),
          );
        }
      case noTaskRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const NoTaskScreen(),
          );
        }
    }
    return null;
  }
}
