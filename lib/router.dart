import 'package:flutter/material.dart';
import 'package:libraryprox_remote/features/auth/screens/auth_qr_screen.dart';
import 'package:libraryprox_remote/features/auth/screens/auth_srceen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/about_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/books_actions_screens.dart';
import 'package:libraryprox_remote/features/dashboard/screens/books_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/borrow_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/home_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/logs_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/profile_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/settings_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/students_actions_screens.dart';
import 'package:libraryprox_remote/features/dashboard/screens/students_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/users_screen.dart';

Route<dynamic> generateRouter(RouteSettings routerSettings) {
  switch (routerSettings.name) {
    case AuthScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const AuthScreen(),
      );
    case QrScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const QrScreen(),
      );
    case HomeScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const HomeScreen(),
      );
    case BooksScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const BooksScreen(),
      );
    case StudentsScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const StudentsScreen(),
      );
    case BorrowScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const BorrowScreen(),
      );
    case LogsScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const LogsScreen(),
      );
    case UsersScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const UsersScreen(),
      );
    case SettingsScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const SettingsScreen(),
      );
    case ProfileScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const ProfileScreen(),
      );
    case BooksActionsScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const BooksActionsScreen(),
      );

    case StudentsActionsScreen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const StudentsActionsScreen(),
      );
    case AboutSceen.routerName:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const AboutSceen(),
      );
    default:
      return MaterialPageRoute(
        settings: routerSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen is not Exists'),
          ),
        ),
      );
  }
}
