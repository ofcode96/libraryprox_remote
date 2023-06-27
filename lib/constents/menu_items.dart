// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:libraryprox_remote/features/dashboard/screens/about_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/books_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/borrow_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/home_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/logs_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/students_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/users_screen.dart';
import 'package:libraryprox_remote/models/menu_data_model.dart';

List<MenuData> menuItems = <MenuData>[
  MenuData(
    name: "Home",
    route: HomeScreen.routerName,
    icon: Icons.home_outlined,
  ),
  MenuData(
    name: "Books",
    route: BooksScreen.routerName,
    icon: Icons.book,
  ),
  MenuData(
    name: "Students",
    route: StudentsScreen.routerName,
    icon: Icons.man_4_outlined,
  ),
  MenuData(
    name: "Borrows",
    route: BorrowScreen.routerName,
    icon: Icons.safety_check_rounded,
  ),
  MenuData(
    name: "Logs",
    route: LogsScreen.routerName,
    icon: Icons.history,
  ),
  MenuData(
    name: "Users",
    route: UsersScreen.routerName,
    icon: Icons.security,
  ),
  MenuData(
    name: "About",
    route: AboutSceen.routerName,
    icon: Icons.info,
  ),
];
