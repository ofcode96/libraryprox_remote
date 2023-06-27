// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/card_dashboard.dart';
import 'package:libraryprox_remote/features/dashboard/screens/books_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/borrow_screen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/students_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/books_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/borrows_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/students_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardsDashboard extends StatefulWidget {
  const CardsDashboard({
    super.key,
  });

  @override
  State<CardsDashboard> createState() => _CardsDashboardState();
}

class _CardsDashboardState extends State<CardsDashboard> {
  BorrowsServices borrowsServices = BorrowsServices();
  BooksServices booksServices = BooksServices();
  StudentServices studentServices = StudentServices();

  int? borrowLen = 0;
  int bookLen = 0;
  int studentLen = 0;

  initData() async {
    var borrows = await borrowsServices.getAllBorrow(context, null);
    borrowLen = borrows.length;

    var books = await booksServices.getAllBooks(context, null);
    bookLen = books.length;
    var students = await studentServices.getAllStudents(context, null);
    studentLen = students.length;

    setState(() {});
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    initData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    return Column(
      children: [
        CardDashboard(
          section: local.borrow,
          counter: "$borrowLen",
          icon: Icons.access_time_outlined,
          color: Colors.amber[500],
          onTap: () {
            Navigator.of(context).pushReplacementNamed(BorrowScreen.routerName);
          },
        ),
        CardDashboard(
          section: local.book,
          counter: "$bookLen",
          icon: Icons.book,
          color: Colors.greenAccent,
          onTap: () {
            Navigator.of(context).pushReplacementNamed(BooksScreen.routerName);
          },
        ),
        CardDashboard(
          section: local.student,
          counter: "$studentLen",
          icon: Icons.man,
          color: Colors.red,
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(StudentsScreen.routerName);
          },
        ),
      ],
    );
  }
}
